import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_sample/core/remote/model/nifty/nifty_fifty_response.dart';
import 'package:flutter_sample/ui/screens/watchlist/watchlist_vm.dart';
import 'package:flutter_sample/ui/screens/watchlist/widgets/stock_item_tile.dart';
import 'package:flutter_sample/ui/shared/widgets/custom_app_bar.dart';
import 'package:flutter_sample/ui/shared/widgets/ui_state_builder.dart';

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({super.key});

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  @override
  void initState() {
    super.initState();
    // Initial data fetch
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WatchlistVm>().fetchNiftyList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(title: 'Watchlist'),
      ),
      body: Consumer<WatchlistVm>(
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
    );
  }

  Widget _buildStockList(WatchlistVm vm) {
    final stocks = vm.niftyStocks;
    if (stocks.isEmpty) {
      return const Center(child: Text('No stocks available'));
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
