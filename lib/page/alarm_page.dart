import 'package:flutter/material.dart';
import '../service/alarm_functions.dart';

class AlarmPage extends StatefulWidget {
  @override
  _AlarmPageState createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  AlarmFunctions alarmFunctions = AlarmFunctions();

  @override
  void initState() {
    super.initState();
    alarmFunctions.refreshPage = refreshPage;
    setState(() {
      alarmFunctions.initializeAlarm();
    });
  }

  void refreshPage() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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
          Flexible(
            child: Container(
              child: ListView.builder(
                itemCount: alarmFunctions.alarms.length,
                itemBuilder: (context, index) {
                  final alarm = alarmFunctions.alarms[index];
                  return ListTile(
                    title: Text(
                      '${alarm.date.hour.toString().padLeft(2, '0')}:${alarm.date.minute.toString().padLeft(2, '0')}',
                      style: TextStyle(fontSize: 18),
                    ),
                    subtitle: Text(
                      '${alarm.date.day}/${alarm.date.month}/${alarm.date.year}',
                      style: TextStyle(fontSize: 16),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        alarmFunctions.deleteAlarm(alarm).then((_) {
                          setState(() {});
                        });
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
