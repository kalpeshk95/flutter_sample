import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'network_exception.freezed.dart';

@freezed
class NetworkExceptions with _$NetworkExceptions {
  const factory NetworkExceptions.requestCancelled() = RequestCancelled;

  const factory NetworkExceptions.unauthorisedRequest() = UnauthorisedRequest;

  const factory NetworkExceptions.badRequest() = BadRequest;

  const factory NetworkExceptions.notFound(String message) = NotFound;

  const factory NetworkExceptions.methodNotAllowed() = MethodNotAllowed;

  const factory NetworkExceptions.notAcceptable() = NotAcceptable;

  const factory NetworkExceptions.requestTimeout() = RequestTimeout;

  const factory NetworkExceptions.sendTimeout() = SendTimeout;

  const factory NetworkExceptions.conflict() = Conflict;

  const factory NetworkExceptions.internalServerError() = InternalServerError;

  const factory NetworkExceptions.notImplemented() = NotImplemented;

  const factory NetworkExceptions.serviceUnavailable() = ServiceUnavailable;

  const factory NetworkExceptions.noInternetConnection() = NoInternetConnection;

  const factory NetworkExceptions.formatException() = FormatException;

  const factory NetworkExceptions.unableToProcess() = UnableToProcess;

  const factory NetworkExceptions.defaultError(String message) = DefaultError;

  const factory NetworkExceptions.unexpectedError() = UnexpectedError;

  const factory NetworkExceptions.tokenExpired() = TokenExpired;

  const factory NetworkExceptions.invalidToken() = InvalidToken;

  static NetworkExceptions getDioException(dynamic error) {
    if (error is Exception) {
      if (error is DioException) {
        return _handleDioException(error);
      } else if (error is SocketException) {
        return const NetworkExceptions.noInternetConnection();
      } else if (error is FormatException) {
        return const NetworkExceptions.formatException();
      } else {
        return const NetworkExceptions.unexpectedError();
      }
    } else {
      return const NetworkExceptions.unexpectedError();
    }
  }

  static NetworkExceptions _handleDioException(DioException error) {
    switch (error.type) {
      case DioExceptionType.cancel:
        return const NetworkExceptions.requestCancelled();
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
        return const NetworkExceptions.requestTimeout();
      case DioExceptionType.receiveTimeout:
        return const NetworkExceptions.sendTimeout();
      case DioExceptionType.badResponse:
        return _handleResponseError(error.response);
      case DioExceptionType.unknown:
        if (error.message.toString().contains('SocketException')) {
          return const NetworkExceptions.noInternetConnection();
        } else {
          return const NetworkExceptions.unexpectedError();
        }
      default:
        return const NetworkExceptions.unexpectedError();
    }
  }

  static NetworkExceptions _handleResponseError(Response? response) {
    if (response == null || response.statusCode == null) {
      return const NetworkExceptions.unexpectedError();
    }

    final statusCode = response.statusCode;
    final data = response.data;
    final message = _extractMessage(data);

    switch (statusCode) {
      case 400:
        return message != null
            ? NetworkExceptions.defaultError(message)
            : const NetworkExceptions.badRequest();
      case 401:
        return const NetworkExceptions.unauthorisedRequest();
      case 403:
        return const NetworkExceptions.tokenExpired();
      case 404:
        return message != null
            ? NetworkExceptions.notFound(message)
            : const NetworkExceptions.notFound('Not found');
      case 409:
        return const NetworkExceptions.conflict();
      case 500:
        return const NetworkExceptions.internalServerError();
      case 503:
        return const NetworkExceptions.serviceUnavailable();
      default:
        return message != null
            ? NetworkExceptions.defaultError(message)
            : const NetworkExceptions.unexpectedError();
    }
  }

  static String? _extractMessage(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data['message'] ?? data['error']?.toString();
    } else if (data is String) {
      try {
        final map = jsonDecode(data) as Map<String, dynamic>;
        return map['message'] ?? map['error']?.toString();
      } catch (_) {
        return data;
      }
    }
    return null;
  }

  static String getErrorMessage(NetworkExceptions exception) {
    return exception.when(
      requestCancelled: () => "Request cancelled",
      unauthorisedRequest: () => "Unauthorised request",
      badRequest: () => "Bad request",
      notFound: (message) => message,
      methodNotAllowed: () => "Method not allowed",
      notAcceptable: () => "Not acceptable",
      requestTimeout: () => "Request timeout",
      sendTimeout: () => "Send timeout",
      conflict: () => "Conflict",
      internalServerError: () => "Internal server error",
      notImplemented: () => "Not implemented",
      serviceUnavailable: () => "Service unavailable",
      noInternetConnection: () => "No internet connection",
      formatException: () => "Format exception",
      unableToProcess: () => "Unable to process data",
      defaultError: (message) => message,
      unexpectedError: () => "Unexpected error occurred",
      tokenExpired: () => "Token expired",
      invalidToken: () => "Invalid token",
    );
  }
}
