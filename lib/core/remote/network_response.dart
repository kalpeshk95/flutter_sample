import 'package:freezed_annotation/freezed_annotation.dart';

part 'network_response.freezed.dart';

@freezed
class NetworkResponse<T> with _$NetworkResponse<T> {
  const factory NetworkResponse.success({required T data}) = SUCCESS<T>;

  const factory NetworkResponse.failure(String error) = FAILURE;

  factory NetworkResponse.error(String error) => NetworkResponse.failure(error);
}
