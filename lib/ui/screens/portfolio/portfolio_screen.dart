import 'package:flutter/material.dart';
import 'package:flutter_sample/core/theme/text_style_extensions.dart';
import 'package:flutter_sample/ui/screens/portfolio/widget/portfolio_summary.dart';
import 'package:flutter_sample/ui/screens/portfolio/widget/sort_bottom_sheet.dart';
import 'package:flutter_sample/ui/shared/utility/extension.dart';
import 'package:flutter_sample/ui/shared/widgets/ui_state_builder.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_typography.dart';
import '../../shared/widgets/custom_app_bar.dart';
import '../../shared/widgets/search_field.dart';
import '../empty/empty_screen.dart';
import 'holding_data.dart';
import 'portfolio_vm.dart';

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({super.key});

  void _openFilterSheet(BuildContext context) {
    final vm = context.read<PortfolioVm>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SortBottomSheet(
          selectedSort: vm.selectedSort,
          direction: vm.sortDirection,
          onSelected: vm.updateSort,
          onClear: () {
            vm.updateSort(SortBy.name, SortDirection.none);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(
        title: 'Portfolio',
        backgroundColor: Colors.transparent,
        showBackButton: false,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              colorScheme.primary.withOpacity(0.05),
              colorScheme.surface,
            ],
          ),
        ),
        child: SafeArea(
          child: Consumer<PortfolioVm>(
            builder: (_, vm, __) {
              return UiStateBuilder<List<HoldingData>>(
                uiState: vm.holdingsState,
                onSuccess: (_) => RefreshIndicator.adaptive(
                  color: colorScheme.primary,
                  backgroundColor: colorScheme.surface,
                  onRefresh: vm.fetchHoldings,
                  child: Column(
                    children: [
                      SearchField(
                        hintText: 'Search holdings...',
                        searchQuery: vm.searchText,
                        onChanged: vm.updateSearch,
                        showFilterButton: true,
                        onFilterTap: () => _openFilterSheet(context),
                      ),
                      if (vm.sortedFilteredHoldings.isEmpty)
                        _buildEmptyState(vm)
                      else
                        _buildHoldingsList(vm),
                      // Fixed bottom summary
                      if (vm.sortedFilteredHoldings.isNotEmpty)
                        PortfolioSummary(
                          currValue: vm.currValue,
                          currInvest: vm.currInvest,
                          todayPnL: vm.todayPnL,
                          totalPnL: vm.totalPnL,
                        )
                    ],
                  ),
                ),
                onRetry: vm.fetchHoldings,
                showRetryOnEmpty: true,
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(PortfolioVm vm) {
    return Expanded(
      child: EmptyScreen(
        message: vm.searchText.isNotEmpty ? 'No results found' : 'No holdings available',
        subtitle: vm.searchText.isNotEmpty
            ? 'Try a different search term'
            : 'Add stocks to your portfolio to see them here',
        actionText: vm.searchText.isNotEmpty ? 'Clear Search' : 'Refresh',
        onActionPressed: vm.searchText.isNotEmpty ? () => vm.updateSearch('') : vm.fetchHoldings,
        icon: Icons.account_balance_wallet_outlined,
      ),
    );
  }

  Widget _buildHoldingsList(PortfolioVm vm) {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemCount: vm.sortedFilteredHoldings.length,
        itemBuilder: (_, i) => Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: HoldingTile(holding: vm.sortedFilteredHoldings[i]),
        ),
      ),
    );
  }
}

class HoldingTile extends StatelessWidget {

  const HoldingTile({required this.holding, super.key});
  final HoldingData holding;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final changeColor = holding.pnl.getPLColor;
    final symbol = holding.symbol.isNotEmpty ? holding.symbol[0].toUpperCase() : '\u20B9';

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: colorScheme.outlineVariant.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // First row - Symbol and LTP
            Row(
              children: [
                Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    color: colorScheme.primary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      symbol,
                      style: AppTypography.twentyTwo.semiBold.withColor(colorScheme.primary),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  holding.symbol,
                  style: AppTypography.sixteen.semiBold.withColor(colorScheme.onSurface),
                ),
                const Spacer(),
                Text(
                  'LTP : ',
                  style: AppTypography.twelve.medium.withColor(colorScheme.onSurfaceVariant),
                ),
                Text(
                  holding.ltp.formatCurrency(),
                  style: AppTypography.fourteen.withColor(colorScheme.onSurface),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Second row - Quantity and P&L
            Row(
              children: [
                Text(
                  'QTY : ',
                  style: AppTypography.twelve.medium.withColor(colorScheme.onSurfaceVariant),
                ),
                const SizedBox(height: 2),
                Text(
                  holding.quantity.toString(),
                  style: AppTypography.fourteen.withColor(colorScheme.onSurface),
                ),
                const Spacer(),
                Text(
                  'P&L : ',
                  style: AppTypography.twelve.medium.withColor(colorScheme.onSurfaceVariant),
                ),
                const SizedBox(height: 2),
                Text(
                  holding.pnl.abs().formatCurrency(),
                  style: AppTypography.fourteen.medium.withColor(changeColor),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
