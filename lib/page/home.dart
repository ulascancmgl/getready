import 'package:flutter/material.dart';
import 'package:getready/style/style.dart';
import 'package:getready/style/theme_changer.dart';

import '../style/settings_drawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ThemeChanger themeChanger = ThemeChanger();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              _scaffoldKey.currentState!.openEndDrawer();
            },
          ),
        ],
        title: const Center(
          child: Text('Alarmio', style: AppStyles.bodyLargeText),
        ),
      ),
      endDrawer: AppDrawer(themeChanger: themeChanger),
    );
  }
}
