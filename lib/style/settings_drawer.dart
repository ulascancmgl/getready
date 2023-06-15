import 'package:flutter/material.dart';
import 'package:getready/style/style.dart';
import 'package:getready/style/theme_changer.dart';

class AppDrawer extends StatelessWidget {
  final ThemeChanger themeChanger;

  const AppDrawer({required this.themeChanger});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.indigo,
            ),
            child: Text(
              'Settings',
              style: AppStyles.bodyLargeText,
            ),
          ),
          ExpansionTile(
            title: const Row(
              children: [
                Icon(Icons.settings_applications, size: 24),
                SizedBox(width: 10),
                Text(
                  'Application Settings',
                  style: AppStyles.bodyMediumText,
                ),
              ],
            ),
            children: [
              ListTile(
                title: const Row(
                  children: [
                    Icon(Icons.delete_forever, size: 24),
                    Text(
                      'Clear Application Data',
                      style: AppStyles.bodySmallText,
                    ),
                  ],
                ),
                onTap: () {},
              ),
              ListTile(
                title: const Row(
                  children: [
                    Icon(Icons.color_lens, size: 24),
                    Text(
                      'Change Background Color',
                      style: AppStyles.bodySmallText,
                    ),
                  ],
                ),
                onTap: () {
                  themeChanger.showColorPicker(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
