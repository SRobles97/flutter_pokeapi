import 'package:flutter/material.dart';

class StyleHelper {
  static String idStylized(String id) {
    return '#${id.toString().padLeft(3, '0')}';
  }

  static String firstLetterUpperCased(String text) {
    return text[0].toUpperCase() + text.substring(1);
  }

  static const TextTheme _textTheme = TextTheme(
    displayLarge: TextStyle(fontSize: 24, fontFamily: 'VT323'),
    displayMedium: TextStyle(fontSize: 20, fontFamily: 'VT323'),
    displaySmall: TextStyle(fontSize: 16, fontFamily: 'VT323'),
    bodyLarge:
        TextStyle(fontSize: 16, fontFamily: 'VT323', color: Colors.white),
    bodyMedium:
        TextStyle(fontSize: 14, fontFamily: 'VT323', color: Colors.white),
    bodySmall:
        TextStyle(fontSize: 12, fontFamily: 'VT323', color: Colors.white),
    titleLarge: TextStyle(
        fontSize: 28,
        fontFamily: 'VT323',
        color: Colors.white,
        fontWeight: FontWeight.w200,
        letterSpacing: 2),
    titleMedium: TextStyle(fontSize: 16, fontFamily: 'VT323'),
    titleSmall: TextStyle(fontSize: 12, fontFamily: 'VT323'),
  );

  static ThemeData theme = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF9E2A2B)),
      brightness: Brightness.light,
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF9E2A2B),
        foregroundColor: Colors.white,
      ),
      textTheme: _textTheme,
      useMaterial3: true);
}
