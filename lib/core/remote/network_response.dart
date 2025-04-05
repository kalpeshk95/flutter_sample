
import 'package:freezed_annotation/freezed_annotation.dart';

import 'network_exception.dart';

part 'network_response.freezed.dart';

@freezed
class NetworkResponse<T> with _$NetworkResponse<T> {
  const factory NetworkResponse.success({required T data}) = SUCCESS<T>;
  const factory NetworkResponse.failure({required NetworkExceptions error}) = FAILURE<T>;
  const factory NetworkResponse.loading(String message) = LOADING;
  factory NetworkResponse.error(NetworkExceptions error) => NetworkResponse.failure(error: NetworkExceptions.defaultError(error.toString()));
}
