import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import '../model/alarm_model2.dart';

extension IterableExtension<T> on Iterable<T> {
  T? reduceOrNull(T Function(T, T) combine) {
    if (isEmpty) return null;
    return reduce(combine);
  }
}

class AlarmFunctions2 {
  SharedPreferences? _prefs;
  List<Alarm2> alarms = [];
  VoidCallback? refreshPage;

  Future<void> initializeAlarm2() async {
    _prefs = await SharedPreferences.getInstance();
    final alarmData = _prefs!.getStringList('alarms');
    if (alarmData != null) {
      alarms =
          alarmData.map((data) => Alarm2.fromMap(json.decode(data))).toList();
    }
  }

  Future<void> saveAlarm2(Alarm2 alarm) async {
    alarms.add(alarm);
    await saveAlarmsToPrefs2();
    await initializeAlarm2();
    refreshPage?.call();
  }

  Future<void> deleteAlarm2(Alarm2 alarm) async {
    alarms.remove(alarm);
    await saveAlarmsToPrefs2();
  }

  Future<void> saveAlarmsToPrefs2() async {
    final alarmData = alarms.map((alarm) => alarm.toMap()).toList();
    await _prefs!.setStringList(
        'alarms', alarmData.map((data) => json.encode(data)).toList());
  }

  String getClosestAlarmTime2() {
    if (alarms.isEmpty) return 'No alarms';

    final now = DateTime.now();
    final upcomingAlarms = alarms.where((alarm) {
      final currentDay = now.weekday;
      return alarm.days.contains(currentDay) &&
          alarm.hour >= now.hour &&
          (alarm.hour > now.hour || alarm.minute > now.minute);
    }).toList();

    if (upcomingAlarms.isEmpty) {
      return 'No upcoming alarms';
    }

    final closestAlarm = upcomingAlarms.reduceOrNull((a, b) {
      final aDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        a.hour,
        a.minute,
      );
      final bDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        b.hour,
        b.minute,
      );
      return aDateTime.isBefore(bDateTime) ? a : b;
    });

    if (closestAlarm == null) {
      return 'No closest alarm found';
    }

    final timeDifference = DateTime(
      now.year,
      now.month,
      now.day,
      closestAlarm.hour,
      closestAlarm.minute,
    ).difference(now);

    if (timeDifference.inDays >= 1) {
      final days = timeDifference.inDays.floor();
      return '$days day${days > 1 ? 's' : ''}';
    } else {
      final hours = timeDifference.inHours.floor();
      return '$hours hour${hours > 1 ? 's' : ''}';
    }
  }

  Future<void> showAlarmDialog2(BuildContext context) async {
    TimeOfDay selectedTime = TimeOfDay.now();
    List<int> selectedDays = [];

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
                  Text('Select Days:'),
                  Wrap(
                    spacing: 8,
                    children: List<Widget>.generate(7, (index) {
                      final dayIndex = index + 1;
                      return FilterChip(
                        label: Text(getWeekdayName(dayIndex)),
                        selected: selectedDays.contains(dayIndex),
                        onSelected: (selected) {
                          setState(() {
                            if (selected) {
                              selectedDays.add(dayIndex);
                            } else {
                              selectedDays.remove(dayIndex);
                            }
                          });
                        },
                      );
                    }),
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
                  final alarm = Alarm2(
                    isActive: true,
                    hour: selectedTime.hour,
                    minute: selectedTime.minute,
                    days: selectedDays,
                  );
                  await saveAlarm2(alarm);
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

  String getWeekdayName(int dayIndex) {
    switch (dayIndex) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return '';
    }
  }
}
