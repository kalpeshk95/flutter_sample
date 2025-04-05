enum Status { loading, success, error }

class UiState<T> {
  final T? data;
  final String? error;
  final Status status;

  UiState._({this.data, this.error, required this.status});

  factory UiState.loading() => UiState._(status: Status.loading);

  factory UiState.success(T data) => UiState._(data: data, status: Status.success);

  factory UiState.error(String error) => UiState._(error: error, status: Status.error);
}
