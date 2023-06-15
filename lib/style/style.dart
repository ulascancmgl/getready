import 'package:flutter/material.dart';

class AppStyles {
  static const TextStyle bodySmallText = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );

  static const TextStyle bodyMediumText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const TextStyle bodyLargeText = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const TextStyle bodyExtraLargeText = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static final ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
    textStyle: bodyMediumText,
    fixedSize: Size(150, 50),
    backgroundColor: Colors.blue,
    foregroundColor: Colors.white,
    padding: EdgeInsets.all(8),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );
}
