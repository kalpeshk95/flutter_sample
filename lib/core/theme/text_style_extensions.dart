// lib/core/extensions/text_style_extensions.dart
import 'package:flutter/material.dart';

extension ThemeContextExtension on BuildContext {
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
}

extension BuildContextExtension on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;

  TextTheme get primaryTextTheme => Theme.of(this).primaryTextTheme;

  TextTheme get accentTextTheme => Theme.of(this).textTheme;

  ColorScheme get colorScheme => Theme.of(this).colorScheme;
}

extension TextStyleExtension on TextStyle {
  // Font weight helpers
  TextStyle get bold => copyWith(fontWeight: FontWeight.w700);

  TextStyle get semiBold => copyWith(fontWeight: FontWeight.w600);

  TextStyle get medium => copyWith(fontWeight: FontWeight.w500);

  TextStyle get regular => copyWith(fontWeight: FontWeight.w400);

  TextStyle get light => copyWith(fontWeight: FontWeight.w300);

  // Color helpers
  TextStyle withColor(Color color) => copyWith(color: color);

  TextStyle withOpacity(double opacity) => copyWith(
        color: color?.withOpacity(opacity),
      );

  // Size helpers
  TextStyle withSize(double size) => copyWith(fontSize: size);

  TextStyle withHeight(double height) => copyWith(height: height);

  TextStyle withLetterSpacing(double spacing) => copyWith(letterSpacing: spacing);
}
