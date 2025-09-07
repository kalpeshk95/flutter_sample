import 'package:flutter/material.dart';
import 'package:flutter_sample/core/theme/app_typography.dart';

enum SortDirection { none, ascending, descending }

enum SortBy { name, qty, ltp, pnl }

extension SortByLabel on SortBy {
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
  late SortBy? currentSort;
  late SortDirection currentDirection;

  @override
  void initState() {
    super.initState();
    currentSort = widget.selectedSort;
    currentDirection = widget.direction;
  }

  void _cycleDirection(SortBy sort) {
    setState(() {
      if (currentSort != sort) {
        currentSort = sort;
        currentDirection = SortDirection.ascending;
      } else {
        switch (currentDirection) {
          case SortDirection.none:
            currentDirection = SortDirection.ascending;
            break;
          case SortDirection.ascending:
            currentDirection = SortDirection.descending;
            break;
          case SortDirection.descending:
            currentDirection = SortDirection.none;
            currentSort = null;
            break;
        }
      }

      widget.onSelected(currentSort ?? sort, currentDirection);
    });
  }

  IconData _getSortIcon(SortDirection direction) {
    switch (direction) {
      case SortDirection.ascending:
        return Icons.arrow_downward_rounded;
      case SortDirection.descending:
        return Icons.arrow_upward_rounded;
      case SortDirection.none:
        return Icons.swap_vert;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Drag handle
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: colorScheme.onSurfaceVariant.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),

              // Header
              Row(
                children: [
                  Text(
                    'Sort By',
                    style: AppTypography.titleLarge.copyWith(
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        currentSort = null;
                        currentDirection = SortDirection.none;
                      });
                      widget.onClear();
                    },
                    child: Text(
                      'Clear',
                      style: AppTypography.labelLarge.copyWith(
                        color: colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Sort options
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: SortBy.values.map((sort) {
                  final isSelected = currentSort == sort;
                  return ChoiceChip(
                    label: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          sort.label,
                          style: AppTypography.bodyMedium.copyWith(
                            color: isSelected
                                ? colorScheme.onPrimaryContainer
                                : colorScheme.onSurfaceVariant,
                            fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
                          ),
                        ),
                        if (isSelected && currentDirection != SortDirection.none)
                          Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: Icon(
                              _getSortIcon(currentDirection),
                              size: 18,
                              color: colorScheme.onPrimaryContainer,
                            ),
                          ),
                      ],
                    ),
                    selected: isSelected,
                    onSelected: (_) {
                      _cycleDirection(sort);
                      if (currentSort == null) {
                        Navigator.pop(context);
                      }
                    },
                    backgroundColor: colorScheme.surfaceContainerHighest,
                    selectedColor: colorScheme.primaryContainer,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(
                        color:
                            isSelected ? colorScheme.primaryContainer : colorScheme.outlineVariant,
                        width: 1,
                      ),
                    ),
                    elevation: 0,
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
