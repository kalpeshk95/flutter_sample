import 'package:flutter/material.dart';

class AppTypography {
  // Font family
  static const String primaryFont = 'Poppins';

  // Text styles
  static const TextStyle ten = TextStyle(
    fontFamily: primaryFont,
    fontSize: 10,
    letterSpacing: 1.5,
  );

  static const TextStyle eleven = TextStyle(
    fontFamily: primaryFont,
    fontSize: 11,
    letterSpacing: 0.5,
  );

  static const TextStyle twelve = TextStyle(
    fontFamily: primaryFont,
    fontSize: 12,
    letterSpacing: 0.5,
  );

  static const TextStyle fourteen = TextStyle(
    fontFamily: primaryFont,
    fontSize: 14,
    letterSpacing: 0.25,
  );

  static const TextStyle sixteen = TextStyle(
    fontFamily: primaryFont,
    fontSize: 16,
    letterSpacing: 0.5,
  );

  static const TextStyle eighteen = TextStyle(
    fontFamily: primaryFont,
    fontSize: 18,
    letterSpacing: 0.4,
  );

  static const TextStyle twenty = TextStyle(
    fontFamily: primaryFont,
    fontSize: 20,
    letterSpacing: 0.14,
  );

  static const TextStyle twentyTwo = TextStyle(
    fontFamily: primaryFont,
    fontSize: 22,
    letterSpacing: 0.0,
  );

  static const TextStyle twentyFour = TextStyle(
    fontFamily: primaryFont,
    fontSize: 24,
    letterSpacing: 0.0,
  );

  static const TextStyle twentySix = TextStyle(
    fontFamily: primaryFont,
    fontSize: 26,
    letterSpacing: 0.0,
  );

  static const TextStyle twentyEight = TextStyle(
    fontFamily: primaryFont,
    fontSize: 28,
    letterSpacing: 0.0,
  );

  // Helper to create custom text styles
  static TextStyle custom({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? height,
    double? letterSpacing,
    String? fontFamily,
  }) {
    return TextStyle(
      fontFamily: primaryFont,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }
}
