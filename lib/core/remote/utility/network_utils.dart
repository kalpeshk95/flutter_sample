import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkUtils {
  /// Check both network and actual internet access
  /// Checks if the device has an active internet connection
  ///
  /// Returns `true` if the device is connected to a network (mobile, WiFi, etc.)
  /// and can reach the internet, `false` otherwise.
  static Future<bool> hasInternet() async {
    // Check if there's any network connectivity
    final connectivityResult = await Connectivity().checkConnectivity();

    // If there's no connectivity at all, return false immediately
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    }

    // Additional check: Try to reach a reliable internet address
    try {
      final result = await InternetAddress.lookup('google.com').timeout(const Duration(seconds: 3));

      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    } on TimeoutException catch (_) {
      return false;
    } catch (_) {
      return false;
    }
  }
}
