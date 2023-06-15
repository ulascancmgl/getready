import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeChanger extends ChangeNotifier {
  Color scaffoldColor = Colors.blueGrey;

  Future<void> initializeColor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? savedColor = prefs.getInt('scaffoldColor');
    if (savedColor != null) {
      scaffoldColor = Color(savedColor);
    }
    notifyListeners();
  }

  void changeColor(Color newColor) async {
    scaffoldColor = newColor;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('scaffoldColor', newColor.value);
    notifyListeners();
  }

  void changeScaffoldColor(BuildContext context, Color newColor) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('scaffoldColor');
    await prefs.setInt('scaffoldColor', newColor.value);
    ThemeChanger themeChanger =
    Provider.of<ThemeChanger>(context, listen: false);
    themeChanger.changeColor(newColor);
  }

  void showColorPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('Select Color'),
          children: [
            ListTile(
              title: Text('BlueGrey'),
              onTap: () {
                changeScaffoldColor(context, Colors.blueGrey);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Red'),
              onTap: () {
                changeScaffoldColor(context, Colors.red);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Green'),
              onTap: () {
                changeScaffoldColor(context, Colors.green);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Yellow'),
              onTap: () {
                changeScaffoldColor(context, Colors.yellow);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Orange'),
              onTap: () {
                changeScaffoldColor(context, Colors.orange);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Purple'),
              onTap: () {
                changeScaffoldColor(context, Colors.purple);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Pink'),
              onTap: () {
                changeScaffoldColor(context, Colors.pink);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Teal'),
              onTap: () {
                changeScaffoldColor(context, Colors.teal);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Cyan'),
              onTap: () {
                changeScaffoldColor(context, Colors.cyan);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Amber'),
              onTap: () {
                changeScaffoldColor(context, Colors.amber);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Deep Purple'),
              onTap: () {
                changeScaffoldColor(context, Colors.deepPurple);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Indigo'),
              onTap: () {
                changeScaffoldColor(context, Colors.indigo);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}