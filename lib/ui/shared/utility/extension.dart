import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension ColorExtension on num {
  Color get getPLColor => this >= 0 ? Colors.green : Colors.red;
}

extension CurrencyFormatter on double {
  String formatCurrency() {
    final formatter = NumberFormat("#,##0.00"); // Format with commas
    return "\u{20B9}${formatter.format(this)}"; // Format the double value
  }
}

enum LogType { info, error, warning }

extension DebugLogger on Object {
  void log([LogType type = LogType.info]) {
    if (kDebugMode) {
      final label = {
        LogType.info: '✅ INFO :',
        LogType.error: '❌ ERROR :',
      }[type];
      debugPrint('[$label] $this');
    }
  }
}

// 'Portfolio loaded'.log(); // INFO
// 'Something went wrong'.log(LogType.error);
