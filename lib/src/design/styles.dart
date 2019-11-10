import 'package:flutter/material.dart';

class AppThemes {
  static ThemeData get lightTheme => ThemeData(
        brightness: Brightness.light,
        fontFamily: "Ubuntu",
        primarySwatch: Colors.deepOrange,
        primaryColor: Colors.deepOrange,
        accentColor: Colors.lightGreen,
      );

  static ThemeData get darkTheme => lightTheme.copyWith(brightness: Brightness.dark);
}
