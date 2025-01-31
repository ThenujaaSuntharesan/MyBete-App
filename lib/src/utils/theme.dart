import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF96D8E3)),
    useMaterial3: true,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Color(0xFF1E88E5), // Change this to a suitable dark mode color
      brightness: Brightness.dark, // Ensure the color scheme is dark
    ),
    useMaterial3: true,
  );
}