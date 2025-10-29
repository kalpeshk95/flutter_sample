// lib/ui/shared/widgets/empty_state.dart
import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  final String? searchQuery;
  final String emptyMessage;
  final String? searchMessage;
  final VoidCallback? onClearSearch;
  final Widget? customIcon;
  final String? actionLabel;
  final VoidCallback? onAction;

  const EmptyState({
    this.searchQuery,
    this.emptyMessage = 'No items available',
    this.searchMessage,
    this.onClearSearch,
    this.customIcon,
    this.actionLabel,
    this.onAction,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isSearching = searchQuery != null && searchQuery!.isNotEmpty;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            customIcon ?? Icon(
              isSearching ? Icons.search_off_rounded : Icons.inbox_rounded,
              size: 64,
              color: theme.colorScheme.onSurfaceVariant.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              isSearching
                  ? searchMessage ?? 'No results found'
                  : emptyMessage,
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            if (isSearching) ...[
              const SizedBox(height: 8),
              Text(
                'No items match "$searchQuery"',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant.withOpacity(0.7),
                ),
                textAlign: TextAlign.center,
              ),
            ],
            if (onClearSearch != null && isSearching) ...[
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: onClearSearch,
                icon: const Icon(Icons.clear_rounded, size: 18),
                label: const Text('Clear search'),
                style: FilledButton.styleFrom(
                  backgroundColor: theme.colorScheme.surfaceVariant,
                  foregroundColor: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: 16),
              FilledButton(
                onPressed: onAction,
                child: Text(actionLabel!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}