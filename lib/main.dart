import 'package:flutter/material.dart';
import 'package:getready/style/style.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppStyles.scaffoldBackgroundColor,
        textTheme: TextTheme(
          bodySmall: AppStyles.bodySmallText,
          bodyMedium: AppStyles.bodyMediumText,
          bodyLarge: AppStyles.bodyLargeText,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: AppStyles.elevatedButtonStyle,
        ),
      ),
    );
  }
}
