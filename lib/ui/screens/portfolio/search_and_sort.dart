import 'package:flutter/material.dart';
import 'package:flutter_sample/ui/screens/portfolio/portfolio_vm.dart';
import 'package:provider/provider.dart';

class SearchAndSort extends StatelessWidget {
  final VoidCallback onFilterTap;

  const SearchAndSort({super.key, required this.onFilterTap});

  @override
  Widget build(BuildContext context) {
    final isSearching = context.select<PortfolioVm, bool>((vm) => vm.isSearching);
    final searchText = context.select<PortfolioVm, String>((vm) => vm.searchText);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(
        children: [
          if (isSearching) ...[
            Expanded(
              child: TextField(
                controller: TextEditingController(text: searchText)
                  ..selection = TextSelection.collapsed(offset: searchText.length),
                onChanged: context.read<PortfolioVm>().updateSearch,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
                autofocus: true,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.clear_rounded),
              onPressed: () {
                context.read<PortfolioVm>().toggleSearch();
              },
            )
          ] else ...[
            IconButton(icon: const Icon(Icons.swap_vert_rounded), onPressed: onFilterTap),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.search_rounded),
              onPressed: () => context.read<PortfolioVm>().toggleSearch(),
            ),
          ]
        ],
      ),
    );
  }
}
