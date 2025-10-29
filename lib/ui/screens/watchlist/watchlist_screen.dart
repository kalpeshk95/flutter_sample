// Update watchlist_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_sample/core/remote/model/nifty/nifty_fifty_response.dart';
import 'package:flutter_sample/ui/screens/watchlist/watchlist_vm.dart';
import 'package:flutter_sample/ui/screens/watchlist/widgets/stock_item_tile.dart';
import 'package:flutter_sample/ui/shared/widgets/custom_app_bar.dart';
import 'package:flutter_sample/ui/shared/widgets/empty_state.dart';
import 'package:flutter_sample/ui/shared/widgets/ui_state_builder.dart';
import 'package:provider/provider.dart';

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({super.key});

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WatchlistVm>().fetchNiftyList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(title: 'Watchlist'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Consumer<WatchlistVm>(
              builder: (context, vm, _) => TextField(
                controller: TextEditingController(text: vm.searchQuery),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface,
                ),
                decoration: InputDecoration(
                  hintText: 'Search stocks...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                ),
                onChanged: vm.setSearchQuery,
              ),
            ),
          ),
          Expanded(
            child: Consumer<WatchlistVm>(
              builder: (context, vm, _) {
                return RefreshIndicator(
                  onRefresh: vm.fetchNiftyList,
                  child: UiStateBuilder<List<Datum>>(
                    uiState: vm.niftyFiftyList,
                    onSuccess: (_) => _buildStockList(vm),
                    onRetry: vm.fetchNiftyList,
                    showRetryOnEmpty: true,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStockList(WatchlistVm vm) {
    final stocks = vm.niftyStocks;

    if (stocks.isEmpty) {
      return EmptyState(
        searchQuery: vm.searchQuery.isNotEmpty ? vm.searchQuery : null,
        emptyMessage: 'No stocks available',
        onClearSearch: vm.searchQuery.isNotEmpty ? () => vm.setSearchQuery('') : null,
      );
    }

    return ListView.builder(
      itemCount: stocks.length,
      itemBuilder: (_, i) => StockItemTile(
        key: ValueKey(stocks[i].symbol),
        datum: stocks[i],
      ),
    );
  }
}
