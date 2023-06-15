import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'lang.dart';

class LanguageUtils {
  String? currentLanguage;

  Iterable<Locale> get supportedLocales {
    return [
      const Locale('en', ''),
      const Locale('tr', ''),
      const Locale('fr', ''),
    ];
  }

  Future<void> loadSelectedLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? selectedLanguage = prefs.getString('selectedLanguage');
    if (selectedLanguage != null) {
      currentLanguage = selectedLanguage;
    } else {
      String preferredLanguage =
          (await PlatformDispatcher.instance.locale) as String;

      if (supportedLocales
          .contains(Locale.fromSubtags(languageCode: preferredLanguage))) {
        currentLanguage = preferredLanguage;
      } else {
        currentLanguage = 'en';
      }
    }
  }

  Future<void> saveSelectedLanguage(String selectedLanguage) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedLanguage', selectedLanguage);
  }

  String getTranslatedString(String originalString) {
    return allTranslations[currentLanguage]?[originalString] ?? originalString;
  }

  Future<void> changeLanguage(String languageCode) async {
    currentLanguage = languageCode;
    await saveSelectedLanguage(languageCode);
    await loadSelectedLanguage();
  }
}
