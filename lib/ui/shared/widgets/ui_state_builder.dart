import 'package:flutter/material.dart';

import '../utility/ui_state.dart';

class UiStateBuilder<T> extends StatelessWidget {
  final UiState<T> uiState;
  final Widget Function(T data) onSuccess;
  final Widget? loadingWidget;
  final Widget? errorWidget;

  const UiStateBuilder({
    super.key,
    required this.uiState,
    required this.onSuccess,
    this.loadingWidget,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    switch (uiState.status) {
      case Status.loading:
        return loadingWidget ?? const Center(child: CircularProgressIndicator());
      case Status.error:
        return errorWidget ?? Center(child: Text(uiState.error ?? 'Unknown error'));
      case Status.success:
        return onSuccess(uiState.data as T);
    }
  }
}
