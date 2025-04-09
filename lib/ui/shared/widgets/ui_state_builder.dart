import 'package:flutter/material.dart';

import '../utility/ui_state.dart';

class UiStateBuilder<T> extends StatelessWidget {
  final UiState<T> uiState;
  final Widget Function(T data) onSuccess;
  final VoidCallback? onRetry;
  final Widget? loadingWidget;
  final Widget Function(String error)? errorBuilder;

  const UiStateBuilder({
    super.key,
    required this.uiState,
    required this.onSuccess,
    this.onRetry,
    this.loadingWidget,
    this.errorBuilder,
  });

  @override
  Widget build(BuildContext context) {
    switch (uiState.status) {
      case Status.loading:
        return loadingWidget ?? _buildDefaultLoader();
      case Status.error:
        final errorMessage = uiState.error ?? "Unknown error occurred";
        return errorBuilder?.call(errorMessage) ??
            _DefaultErrorView(message: errorMessage, onRetry: onRetry);
      case Status.success:
        final data = uiState.data;
        if (data != null) {
          return onSuccess(data);
        } else {
          return const Center(child: Text("No data available"));
        }
    }
  }

  Widget _buildDefaultLoader() {
    return const Center(child: CircularProgressIndicator());
  }
}

class _DefaultErrorView extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const _DefaultErrorView({
    required this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final icon = message.toLowerCase().contains('internet') ? Icons.wifi_off : Icons.warning;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 60, color: Colors.grey.shade600),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            if (onRetry != null)
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text("Retry"),
              ),
          ],
        ),
      ),
    );
  }
}
