import 'package:flutter/material.dart';

import '../utility/ui_state.dart';

class UiStateBuilder<T> extends StatelessWidget {
  final UiState<T> uiState;
  final Widget Function(T data) onSuccess;
  final VoidCallback? onRetry;
  final Widget? loadingWidget;
  final Widget Function(String error)? errorBuilder;
  final String emptyMessage;
  final bool showRetryOnEmpty;

  const UiStateBuilder({
    super.key,
    required this.uiState,
    required this.onSuccess,
    this.onRetry,
    this.loadingWidget,
    this.errorBuilder,
    this.emptyMessage = "No data available",
    this.showRetryOnEmpty = false,
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
        if (data is Iterable && data.isEmpty) {
          return _DefaultErrorView(
            message: emptyMessage,
            onRetry: showRetryOnEmpty ? onRetry : null,
          );
        } else if (data != null) {
          return onSuccess(data);
        } else {
          return _DefaultErrorView(
            message: emptyMessage,
            onRetry: showRetryOnEmpty ? onRetry : null,
          );
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
    final icon =
        message.toLowerCase().contains('internet') ? Icons.wifi_off_rounded : Icons.warning_rounded;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 60, color: Colors.orangeAccent),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            if (onRetry != null)
              TextButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh, color: Colors.white),
                label: const Text(
                  "Retry",
                  style: TextStyle(color: Colors.white),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
