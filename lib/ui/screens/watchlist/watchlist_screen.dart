import 'package:flutter/material.dart';
import 'package:flutter_sample/core/theme/text_style_extensions.dart';
import 'package:flutter_sample/ui/screens/empty/empty_screen.dart';
import 'package:flutter_sample/ui/screens/watchlist/watchlist_vm.dart';
import 'package:flutter_sample/ui/screens/watchlist/widgets/stock_item_tile.dart';
import 'package:provider/provider.dart';

import '../../../core/remote/model/nifty/nifty_fifty_response.dart';
import '../../shared/widgets/custom_app_bar.dart';
import '../../shared/widgets/search_field.dart';
import '../../shared/widgets/ui_state_builder.dart';

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({super.key});

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<WatchlistVm>().fetchNiftyList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final colorScheme = context.colorScheme;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: const CustomAppBar(
          title: 'Watchlist',
          backgroundColor: Colors.transparent,
          showBackButton: false,
        ),
        body: Container(
          decoration: _buildBackgroundDecoration(colorScheme),
          child: SafeArea(
            child: Consumer<WatchlistVm>(
              builder: (context, vm, _) {
                final stocks = vm.niftyStocks;
                return UiStateBuilder<List<Datum>>(
                  uiState: vm.niftyFiftyList,
                  onSuccess: (_) => RefreshIndicator(
                    onRefresh: vm.fetchNiftyList,
                    color: colorScheme.primary,
                    backgroundColor: colorScheme.surface,
                    child: Column(
                      children: [
                        SearchField(
                          hintText: 'Search stocks...',
                          searchQuery: vm.searchQuery,
                          onChanged: vm.setSearchQuery,
                        ),
                        _buildStocksList(context, vm, stocks),
                      ],
                    ),
                  ),
                  onRetry: vm.fetchNiftyList,
                  showRetryOnEmpty: true,
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildBackgroundDecoration(ColorScheme colorScheme) {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          colorScheme.primary.withValues(alpha: 0.05),
          colorScheme.surface,
        ],
      ),
    );
  }

  Widget _buildStocksList(BuildContext context, WatchlistVm vm, List<Datum> stocks) {
    return Expanded(
      child: stocks.isEmpty
          ? _buildEmptyState(vm)
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: stocks.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: StockItemTile(
                  key: ValueKey('${stocks[index].symbol}_$index'),
                  datum: stocks[index],
                ),
              ),
            ),
    );
  }

  Widget _buildEmptyState(WatchlistVm vm) {
    final searchQuery = vm.searchQuery;
    final isEmptySearch = searchQuery.isNotEmpty;

    return EmptyScreen(
      message: isEmptySearch ? 'No results found' : 'No stocks available',
      subtitle: isEmptySearch
          ? 'Try a different search term'
          : 'Add stocks to your watchlist to see them here',
      actionText: isEmptySearch ? 'Clear Search' : 'Refresh',
      onActionPressed: isEmptySearch ? () => vm.setSearchQuery('') : vm.fetchNiftyList,
      icon: Icons.star_outline_rounded,
    );
  }
}
