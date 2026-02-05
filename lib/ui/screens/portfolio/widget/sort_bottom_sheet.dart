import 'package:flutter/material.dart';
import 'package:flutter_sample/core/theme/text_style_extensions.dart';

import '../../../../core/theme/app_typography.dart';

enum SortDirection { none, ascending, descending }

enum SortBy { name, qty, ltp, pnl }

extension SortByExtension on SortBy {
  String get label {
    switch (this) {
      case SortBy.name:
        return 'Name';
      case SortBy.qty:
        return 'Quantity';
      case SortBy.ltp:
        return 'LTP';
      case SortBy.pnl:
        return 'P&L';
    }
  }
}

class SortBottomSheet extends StatefulWidget {
  final SortBy? selectedSort;
  final SortDirection direction;
  final Function(SortBy sortBy, SortDirection direction) onSelected;
  final VoidCallback onClear;

  const SortBottomSheet({
    super.key,
    required this.selectedSort,
    required this.direction,
    required this.onSelected,
    required this.onClear,
  });

  @override
  State<SortBottomSheet> createState() => _SortBottomSheetState();
}

class _SortBottomSheetState extends State<SortBottomSheet> {
  static const _chipPadding = EdgeInsets.symmetric(horizontal: 16, vertical: 8);

  late SortBy? _currentSort;
  late SortDirection _currentDirection;

  @override
  void initState() {
    super.initState();
    _currentSort = widget.selectedSort;
    _currentDirection = widget.direction;
  }

  @override
  void didUpdateWidget(SortBottomSheet oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedSort != widget.selectedSort || oldWidget.direction != widget.direction) {
      _currentSort = widget.selectedSort;
      _currentDirection = widget.direction;
    }
  }

  void _handleSortChange(SortBy sort) {
    setState(() {
      _currentSort = sort;
      _currentDirection = _getNextDirection(_currentDirection);
      widget.onSelected(_currentSort ?? sort, _currentDirection);
    });
  }

  SortDirection _getNextDirection(SortDirection current) {
    switch (current) {
      case SortDirection.none:
        return SortDirection.ascending;
      case SortDirection.ascending:
        return SortDirection.descending;
      case SortDirection.descending:
        return SortDirection.none;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return SafeArea(
      child: Material(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24.0)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const _DragHandle(),
            _Header(
              onClear: () {
                setState(() {
                  _currentSort = null;
                  _currentDirection = SortDirection.none;
                });
                widget.onClear();
              },
            ),
            Divider(height: 1, color: colorScheme.outlineVariant.withOpacity(0.5)),
            _SortOptions(
              currentSort: _currentSort,
              currentDirection: _currentDirection,
              onSortChanged: _handleSortChange,
            ),
          ],
        ),
      ),
    );
  }
}

class _DragHandle extends StatelessWidget {
  const _DragHandle();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 4),
      child: Center(
        child: Container(
          width: 36.0,
          height: 4.0,
          decoration: BoxDecoration(
            color: context.colorScheme.onSurfaceVariant.withOpacity(0.3),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final VoidCallback onClear;

  const _Header({required this.onClear});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          Text(
            'Sort By',
            style: AppTypography.twenty.semiBold.withColor(colorScheme.onSurface),
          ),
          const Spacer(),
          TextButton(
            onPressed: onClear,
            style: TextButton.styleFrom(
              foregroundColor: colorScheme.primary,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Clear All',
              style: AppTypography.fourteen.medium.withColor(colorScheme.primary),
            ),
          ),
        ],
      ),
    );
  }
}

class _SortOptions extends StatelessWidget {
  final SortBy? currentSort;
  final SortDirection currentDirection;
  final Function(SortBy) onSortChanged;

  const _SortOptions({
    required this.currentSort,
    required this.currentDirection,
    required this.onSortChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: SortBy.values.map((sort) {
          final isSelected = currentSort == sort;
          return _SortChip(
            label: sort.label,
            isSelected: isSelected,
            sortDirection: isSelected ? currentDirection : null,
            onSelected: () => onSortChanged(sort),
          );
        }).toList(),
      ),
    );
  }
}

class _SortChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final SortDirection? sortDirection;
  final VoidCallback onSelected;

  const _SortChip({
    required this.label,
    required this.isSelected,
    this.sortDirection,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final shouldShowAsSelected = isSelected && sortDirection != SortDirection.none;

    return InkWell(
      onTap: onSelected,
      borderRadius: BorderRadius.circular(20.0),
      child: Container(
        padding: _SortBottomSheetState._chipPadding,
        decoration: BoxDecoration(
          color: shouldShowAsSelected ? colorScheme.primaryContainer : colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: shouldShowAsSelected
                ? colorScheme.secondaryContainer
                : colorScheme.outlineVariant.withOpacity(0.3),
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: AppTypography.fourteen.copyWith(
                color: shouldShowAsSelected
                    ? colorScheme.onPrimaryContainer
                    : colorScheme.onSurfaceVariant,
                fontWeight: shouldShowAsSelected ? FontWeight.w500 : FontWeight.normal,
              ),
            ),
            if (shouldShowAsSelected)
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Icon(
                  _getSortIcon(sortDirection!),
                  size: 18.0,
                  color: colorScheme.onPrimaryContainer,
                ),
              ),
          ],
        ),
      ),
    );
  }

  IconData _getSortIcon(SortDirection direction) {
    switch (direction) {
      case SortDirection.ascending:
        return Icons.arrow_upward_rounded;
      case SortDirection.descending:
        return Icons.arrow_downward_rounded;
      case SortDirection.none:
        return Icons.swap_vert_rounded;
    }
  }
}
