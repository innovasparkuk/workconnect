import 'package:flutter/material.dart';

final Color kPrimaryLight = Color(0xFF00A7A7); // teal-green
final Color kAccentLight = Color(0xFF2EB1F2); // soft blue
final Color kBackground = Color(0xFFF2FBFC); // very light cyan
final Color kCard = Colors.white;

ThemeData buildLightTheme() {
  return ThemeData(
    scaffoldBackgroundColor: kBackground,
    primaryColor: kPrimaryLight,
    colorScheme: ColorScheme.light(
      primary: kPrimaryLight,
      secondary: kAccentLight,
    ),
    textTheme: Typography.blackMountainView,
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: kBackground,
      iconTheme: IconThemeData(color: Colors.black87),
      titleTextStyle: TextStyle(
        color: Colors.black87,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    cardTheme: CardThemeData( // ✅ use CardThemeData for older Flutter
      color: kCard,
      elevation: 6,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    iconTheme: IconThemeData(color: Colors.black54),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: kPrimaryLight, // ✅ fixed from `primary`
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
  );
}
