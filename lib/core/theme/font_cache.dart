// lib/core/theme/font_cache.dart
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class FontCache {
  static final Map<String, Future<ByteData>> _fontCache = {};

  static Future<ByteData> loadFont(String path) {
    if (_fontCache.containsKey(path)) {
      return _fontCache[path]!;
    }

    final completer = Completer<ByteData>();
    rootBundle.load(path).then((fontData) {
      _fontCache[path] = Future.value(fontData);
      completer.complete(fontData);
    }).catchError((e) {
      _fontCache.remove(path);
      completer.completeError(e);
    });

    _fontCache[path] = completer.future;
    return completer.future;
  }
}