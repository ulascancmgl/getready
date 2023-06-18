import 'package:flutter/material.dart';
import '../model/alarm_model.dart';
import '../model/alarm_model2.dart';
import '../service/alarm_functions.dart';
import '../service/alarm_functions2.dart';

class AlarmPage extends StatefulWidget {
  @override
  _AlarmPageState createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  AlarmFunctions alarmFunctions = AlarmFunctions();
  AlarmFunctions2 alarmFunctions2 = AlarmFunctions2();

  @override
  void initState() {
    super.initState();
    alarmFunctions.refreshPage = refreshPage;
    alarmFunctions2.refreshPage = refreshPage;
    setState(() {
      alarmFunctions.initializeAlarm();
      alarmFunctions2.initializeAlarm2();
    });
  }

  void refreshPage() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> allAlarms = [
      ...alarmFunctions.alarms,
      ...alarmFunctions2.alarms
    ];

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Next Alarm: ${alarmFunctions.getClosestAlarmTime()}',
              style: TextStyle(fontSize: 18),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              alarmFunctions.showAlarmDialog(context).then((_) {
                setState(() {});
              });
            },
            child: Icon(Icons.add),
          ),
          ElevatedButton(
            onPressed: () {
              alarmFunctions2.showAlarmDialog2(context).then((_) {
                setState(() {});
              });
            },
            child: Icon(Icons.add),
          ),
          Flexible(
            child: Container(
              child: ListView.builder(
                itemCount: allAlarms.length,
                itemBuilder: (context, index) {
                  final alarm = allAlarms[index];
                  return ListTile(
                    title: Text(
                      alarm is Alarm
                          ? '${alarm.date.hour.toString().padLeft(2, '0')}:${alarm.date.minute.toString().padLeft(2, '0')}'
                          : '${alarm.hour.toString().padLeft(2, '0')}:${alarm.minute.toString().padLeft(2, '0')}',
                      style: TextStyle(fontSize: 18),
                    ),
                    subtitle: alarm is Alarm
                        ? Text(
                            '${alarm.date.day}/${alarm.date.month}/${alarm.date.year}',
                            style: TextStyle(fontSize: 16),
                          )
                        : Text(
                            'Days: ${alarm.days.map((dayIndex) => alarmFunctions2.getWeekdayName(dayIndex)).join(", ")}',
                            style: TextStyle(fontSize: 16),
                          ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        if (alarm is Alarm) {
                          alarmFunctions.deleteAlarm(alarm).then((_) {
                            setState(() {});
                          });
                        } else if (alarm is Alarm2) {
                          alarmFunctions2.deleteAlarm2(alarm).then((_) {
                            setState(() {});
                          });
                        }
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
