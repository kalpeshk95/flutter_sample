import 'package:flutter/material.dart';
import 'package:flutter_sample/ui/screens/portfolio/portfolio_vm.dart';
import 'package:provider/provider.dart';

class SearchAndSort extends StatefulWidget {
  final VoidCallback onFilterTap;

  const SearchAndSort({super.key, required this.onFilterTap});

  @override
  State<SearchAndSort> createState() => _SearchAndSortState();
}

class _SearchAndSortState extends State<SearchAndSort> {
  late TextEditingController textController;

  @override
  void initState() {
    super.initState();
    final vm = context.read<PortfolioVm>();
    textController = TextEditingController(text: vm.searchText);
    textController.addListener(() => vm.updateSearch(textController.text));
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<PortfolioVm>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(
        children: [
          if (vm.isSearching) ...[
            Expanded(
              child: TextField(
                controller: textController,
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
              icon: const Icon(Icons.clear),
              onPressed: () {
                textController.clear();
                vm.toggleSearch();
              },
            )
          ] else ...[
            IconButton(icon: const Icon(Icons.sort_rounded), onPressed: widget.onFilterTap),
            const Spacer(),
            IconButton(icon: const Icon(Icons.search), onPressed: vm.toggleSearch),
          ]
        ],
      ),
    );
  }
}
