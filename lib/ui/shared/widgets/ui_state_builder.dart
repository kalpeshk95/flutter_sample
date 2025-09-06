import 'package:flutter/material.dart';

import '../utility/ui_state.dart';

// A reusable widget that handles different UI states (loading, error, success, empty)

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
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: _buildContent(),
    );
  }

  Widget _buildContent() {
    switch (uiState.status) {
      case Status.loading:
        return loadingWidget ?? _buildDefaultLoader();
      case Status.error:
        final errorMessage = uiState.error ?? 'Unknown error occurred';
        return errorBuilder?.call(errorMessage) ??
            _DefaultErrorView(
              key: const ValueKey('error_view'),
              message: errorMessage,
              onRetry: onRetry,
            );
      case Status.success:
        final data = uiState.data;
        if (data == null) {
          return _buildEmptyView();
        }

        if (data is Iterable && data.isEmpty) {
          return _buildEmptyView();
        }

        return onSuccess(data);
    }
  }

  Widget _buildEmptyView() {
    return _DefaultErrorView(
      key: const ValueKey('empty_view'),
      message: emptyMessage,
      onRetry: showRetryOnEmpty ? onRetry : null,
    );
  }
}

Widget _buildDefaultLoader() {
  return const Center(child: CircularProgressIndicator());
}

class _DefaultErrorView extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const _DefaultErrorView({
    super.key,
    required this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final icon = message.toLowerCase().contains('internet')
        ? Icons.wifi_off_rounded
        : Icons.warning_rounded;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 60,
              color: isDark ? theme.colorScheme.secondary : Colors.orangeAccent,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.textTheme.bodyLarge?.color?.withOpacity(0.8),
              ),
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
