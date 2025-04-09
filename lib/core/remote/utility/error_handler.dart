import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';

class ErrorHandler {
  static String getErrorMessage(dynamic error) {
    if (error is SocketException) return 'No internet connection';
    if (error is TimeoutException) return 'Request timed out';
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.cancel:
          return 'Request was cancelled';
        case DioExceptionType.connectionTimeout:
          return 'Connection timeout';
        case DioExceptionType.receiveTimeout:
          return 'Receive timeout';
        case DioExceptionType.badResponse:
          return 'Invalid status code: ${error.response?.statusCode}';
        default:
          return 'Unexpected error occurred';
      }
    }
    return 'An unknown error occurred';
  }
}
