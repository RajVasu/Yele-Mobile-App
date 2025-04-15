import 'package:flutter/material.dart';

class AppMaterialColor {
  static const MaterialColor primaryMaterialColor =
      MaterialColor(_primaryMaterialColorPrimaryValue, <int, Color>{
        50: Color(0xFFE1F3FD),
        100: Color(0xFFB3E1FB),
        200: Color(0xFF80CFFF),
        300: Color(0xFF4DBDFF),
        400: Color(0xFF33B2FF),
        500: Color(_primaryMaterialColorPrimaryValue),
        600: Color(0xFF2F98E6),
        700: Color(0xFF2681CC),
        800: Color(0xFF1F6BA9),
        900: Color(0xFF134D7F),
      });
  static const int _primaryMaterialColorPrimaryValue = 0xFF3FA9F5;

  static const MaterialColor primaryMaterialColorAccent =
      MaterialColor(_primaryMaterialColorAccentValue, <int, Color>{
        100: Color(0xFF76D6FF),
        200: Color(_primaryMaterialColorAccentValue),
        400: Color(0xFF00A9F2),
        700: Color(0xFF0091C8),
      });
  static const int _primaryMaterialColorAccentValue = 0xFF3FA9F5;
}
