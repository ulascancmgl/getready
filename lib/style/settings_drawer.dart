import 'package:flutter/material.dart';
import 'package:getready/style/style.dart';
import 'package:getready/style/theme_changer.dart';

import '../utils/lang_functions.dart';

class AppDrawer extends StatelessWidget {
  final ThemeChanger themeChanger;
  final LanguageUtils languageUtils;

  const AppDrawer({
    required this.themeChanger,
    required this.languageUtils,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.indigo,
            ),
            child: Text(
              languageUtils.getTranslatedString('Settings'),
              style: AppStyles.bodyLargeText,
            ),
          ),
          ExpansionTile(
            title: Row(
              children: [
                Icon(Icons.language_sharp, size: 24),
                SizedBox(width: 10),
                Text(languageUtils.getTranslatedString('Languages')),
              ],
            ),
            children: [
              ListTile(
                title: Row(
                  children: [
                    Text('🇺🇸', style: TextStyle(fontSize: 24)),
                    SizedBox(width: 10),
                    Text('English'),
                  ],
                ),
                onTap: () {
                  languageUtils.changeLanguage('en');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Row(
                  children: [
                    Text('🇹🇷', style: TextStyle(fontSize: 24)),
                    SizedBox(width: 10),
                    Text('Türkçe'),
                  ],
                ),
                onTap: () {
                  languageUtils.changeLanguage('tr');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Row(
                  children: [
                    Text('🇫🇷', style: TextStyle(fontSize: 24)),
                    SizedBox(width: 10),
                    Text('Français'),
                  ],
                ),
                onTap: () {
                  languageUtils.changeLanguage('fr');
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          ExpansionTile(
            title: Row(
              children: [
                Icon(Icons.settings_applications, size: 24),
                SizedBox(width: 10),
                Text(
                  languageUtils.getTranslatedString('Application Settings'),
                  style: AppStyles.bodyMediumText,
                ),
              ],
            ),
            children: [
              ListTile(
                title: Row(
                  children: [
                    Icon(Icons.delete_forever, size: 24),
                    Text(
                      languageUtils
                          .getTranslatedString('Clear Application Data'),
                      style: AppStyles.bodySmallText,
                    ),
                  ],
                ),
                onTap: () {},
              ),
              ListTile(
                title: Row(
                  children: [
                    Icon(Icons.color_lens, size: 24),
                    Text(
                      languageUtils
                          .getTranslatedString('Change Background Color'),
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
