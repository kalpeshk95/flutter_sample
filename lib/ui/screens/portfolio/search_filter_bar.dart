import 'package:flutter/material.dart';
import 'package:flutter_sample/ui/screens/portfolio/portfolio_vm.dart';
import 'package:provider/provider.dart';

class SearchFilterBar extends StatelessWidget {
  final VoidCallback onFilterTap;

  const SearchFilterBar({super.key, required this.onFilterTap});

  @override
  Widget build(BuildContext context) {
    final searchText = context.select<PortfolioVm, String>((vm) => vm.searchText);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: TextEditingController(text: searchText)
                ..selection = TextSelection.collapsed(offset: searchText.length),
              onChanged: context.read<PortfolioVm>().updateSearch,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface,
              ),
              decoration: InputDecoration(
                hintText: 'Search holdings...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            height: 48,
            child: IconButton(
              onPressed: onFilterTap,
              style: IconButton.styleFrom(
                backgroundColor: colorScheme.surfaceContainerHighest,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: Icon(
                Icons.filter_list_rounded,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
