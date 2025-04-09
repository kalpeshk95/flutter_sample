import '../../../ui/shared/utility/ui_state.dart';
import 'network_response.dart';
import 'network_utils.dart';

class ApiExecutor {
  static Future<void> run<T, R>({
    required Future<NetworkResponse<T>> Function() request,
    required void Function(UiState<R> result) onStateChanged,
    R Function(T data)? mapData,
  }) async {
    onStateChanged(UiState.loading());

    final hasInternet = await NetworkUtils.hasInternet();
    if (!hasInternet) {
      onStateChanged(UiState.error("No internet connection"));
      return;
    }

    final response = await request();
    response.when(
      success: (data) {
        final resultData = mapData != null ? mapData(data) : data as R;
        onStateChanged(UiState.success(resultData));
      },
      failure: (error) {
        onStateChanged(UiState.error(error));
      },
    );
  }
}
