import 'package:flutter/material.dart';
import 'package:flutter_sample/core/theme/app_typography.dart';
import 'package:flutter_sample/ui/screens/portfolio/portfolio_vm.dart';
import 'package:provider/provider.dart';

class SearchAndSort extends StatelessWidget {
  final VoidCallback onFilterTap;

  const SearchAndSort({super.key, required this.onFilterTap});

  @override
  Widget build(BuildContext context) {
    final isSearching = context.select<PortfolioVm, bool>((vm) => vm.isSearching);
    final searchText = context.select<PortfolioVm, String>((vm) => vm.searchText);
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          if (isSearching) ...[
            Expanded(
              child: TextField(
                controller: TextEditingController(text: searchText)
                  ..selection = TextSelection.collapsed(offset: searchText.length),
                onChanged: context.read<PortfolioVm>().updateSearch,
                style: AppTypography.bodyMedium,
                decoration: InputDecoration(
                  hintText: 'Search holdings...',
                  hintStyle: AppTypography.bodyMedium.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    color: colorScheme.onSurfaceVariant,
                  ),
                  filled: true,
                  fillColor: colorScheme.surfaceContainerHighest,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: colorScheme.primary,
                      width: 1.5,
                    ),
                  ),
                ),
                autofocus: true,
              ),
            ),
            const SizedBox(width: 4),
            IconButton(
              style: IconButton.styleFrom(
                backgroundColor: colorScheme.surfaceContainerHighest,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: Icon(
                Icons.close_rounded,
                color: colorScheme.onSurfaceVariant,
              ),
              onPressed: () => context.read<PortfolioVm>().toggleSearch(),
            ),
          ] else ...[
            IconButton(
              style: IconButton.styleFrom(
                backgroundColor: colorScheme.surfaceContainerHighest,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: Icon(
                Icons.sort_rounded,
                color: colorScheme.primary,
              ),
              onPressed: onFilterTap,
            ),
            const Spacer(),
            IconButton(
              style: IconButton.styleFrom(
                backgroundColor: colorScheme.surfaceContainerHighest,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: Icon(
                Icons.search_rounded,
                color: colorScheme.primary,
              ),
              onPressed: () => context.read<PortfolioVm>().toggleSearch(),
            ),
          ]
        ],
      ),
    );
  }
}
