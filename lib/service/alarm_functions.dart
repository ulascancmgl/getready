import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import '../model/alarm_model.dart';
import 'dart:convert';

extension IterableExtension<T> on Iterable<T> {
  T? reduceOrNull(T Function(T, T) combine) {
    if (isEmpty) return null;
    return reduce(combine);
  }
}

class AlarmFunctions {
  SharedPreferences? _prefs;
  List<Alarm> alarms = [];
  VoidCallback? refreshPage;

  Future<void> initializeAlarm() async {
    _prefs = await SharedPreferences.getInstance();
    final alarmData = _prefs!.getStringList('alarms');
    if (alarmData != null) {
      alarms =
          alarmData.map((data) => Alarm.fromMap(json.decode(data))).toList();
    }
  }

  Future<void> saveAlarm(Alarm alarm) async {
    alarms.add(alarm);
    await saveAlarmsToPrefs();
    await initializeAlarm();
    refreshPage?.call();
  }

  Future<void> deleteAlarm(Alarm alarm) async {
    alarms.remove(alarm);
    await saveAlarmsToPrefs();
  }

  Future<void> saveAlarmsToPrefs() async {
    final alarmData = alarms.map((alarm) => alarm.toMap()).toList();
    await _prefs!.setStringList(
        'alarms', alarmData.map((data) => json.encode(data)).toList());
  }

  String getClosestAlarmTime() {
    if (alarms.isEmpty) return 'No alarms';

    final now = DateTime.now();
    final upcomingAlarms =
        alarms.where((alarm) => alarm.date.isAfter(now)).toList();

    if (upcomingAlarms.isEmpty) {
      return 'No upcoming alarms';
    }

    final closestAlarm =
        upcomingAlarms.reduceOrNull((a, b) => a.date.isBefore(b.date) ? a : b);

    if (closestAlarm == null) {
      return 'No closest alarm found';
    }

    final timeDifference = closestAlarm.date.difference(now);
    if (timeDifference.inDays >= 1) {
      final days = timeDifference.inDays.floor();
      return '$days day${days > 1 ? 's' : ''}';
    } else {
      final hours = timeDifference.inHours.floor();
      return '$hours hour${hours > 1 ? 's' : ''}';
    }
  }

  Future<void> showAlarmDialog(BuildContext context) async {
    TimeOfDay selectedTime = TimeOfDay.now();
    DateTime selectedDate = DateTime.now();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: Text('Set Alarm'),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Select Time:'),
                  InkWell(
                    onTap: () async {
                      final timePicked = await showTimePicker(
                        context: context,
                        initialTime: selectedTime,
                      );
                      if (timePicked != null) {
                        setState(() {
                          selectedTime = timePicked;
                        });
                      }
                    },
                    child: Text(
                      selectedTime.format(context),
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text('Select Date:'),
                  InkWell(
                    onTap: () async {
                      final datePicked = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(Duration(days: 365)),
                      );
                      if (datePicked != null) {
                        setState(() {
                          selectedDate = datePicked;
                        });
                      }
                    },
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Icon(Icons.calendar_today),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  final alarm = Alarm(
                    isActive: true,
                    hour: selectedTime.hour,
                    minute: selectedTime.minute,
                    date: DateTime(
                      selectedDate.year,
                      selectedDate.month,
                      selectedDate.day,
                      selectedTime.hour,
                      selectedTime.minute,
                    ),
                  );
                  await saveAlarm(alarm);
                  Navigator.of(context).pop();
                  refreshPage!();
                },
                child: Text('Set Alarm'),
              ),
            ],
          );
        });
      },
    );
  }
}
