// lib/core/theme/font_loader.dart
import 'package:flutter/services.dart';

class FontLoaderUtil {
  static Future<void> loadFonts() async {
    await Future.wait([
      _loadFont('Poppins', 'assets/fonts/Poppins-Light.ttf'),
      _loadFont('Poppins', 'assets/fonts/Poppins-Regular.ttf'),
      _loadFont('Poppins', 'assets/fonts/Poppins-Medium.ttf'),
      _loadFont('Poppins', 'assets/fonts/Poppins-SemiBold.ttf'),
      _loadFont('Poppins', 'assets/fonts/Poppins-Bold.ttf'),
    ]);
  }

  static Future<void> _loadFont(String family, String path) async {
    final fontLoader = FontLoader(family);
    fontLoader.addFont(rootBundle.load(path));
    await fontLoader.load();
  }
}