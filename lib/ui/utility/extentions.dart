import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

extension CurrencyFormatter on double {
  String formatCurrency() {
    final formatter = NumberFormat("#,##0.00"); // Format with commas
    return formatter.format(this); // Format the double value
  }
}


extension DebugLogger on Object {
  /// Logs a normal debug message with optional prefix
  void logDebug([String prefix = 'Debug']) {
    if (kDebugMode) {
      print('$prefix ✅: $this');
    }
  }

  /// Logs an error message in debug mode
  void logError([String prefix = 'Error']) {
    if (kDebugMode) {
      print('$prefix ❌: $this');
    }
  }

  /// Logs a warning message in debug mode
  void logWarning([String prefix = 'Warning']) {
    if (kDebugMode) {
      print('$prefix ⚠️: $this');
    }
  }
}
