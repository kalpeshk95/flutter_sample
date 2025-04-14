import 'package:flutter/material.dart';

enum SortDirection { none, ascending, descending }

enum SortBy { name, qty, ltp, pnl }

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
        return Icons.arrow_upward;
      case SortDirection.descending:
        return Icons.arrow_downward;
      case SortDirection.none:
        return Icons.swap_vert;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Text("Sort By", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    setState(() {
                      currentSort = null;
                      currentDirection = SortDirection.none;
                    });
                    widget.onClear();
                  },
                  child: const Text("Clear"),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: SortBy.values.map((sort) {
                final isSelected = currentSort == sort;
                return ChoiceChip(
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(sort.name.toUpperCase()),
                      if (isSelected && currentDirection != SortDirection.none)
                        Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Icon(_getSortIcon(currentDirection), size: 16),
                        ),
                    ],
                  ),
                  selected: isSelected,
                  onSelected: (_) => _cycleDirection(sort),
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}
