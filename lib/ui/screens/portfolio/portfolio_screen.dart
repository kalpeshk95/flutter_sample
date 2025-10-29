import 'package:flutter/material.dart';
import 'package:flutter_sample/ui/screens/portfolio/portfolio_summary.dart';
import 'package:flutter_sample/ui/screens/portfolio/search_and_sort.dart';
import 'package:flutter_sample/ui/screens/portfolio/sort_bottom_sheet.dart';
import 'package:flutter_sample/ui/shared/utility/extension.dart';
import 'package:flutter_sample/ui/shared/widgets/ui_state_builder.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_typography.dart';
import '../../shared/widgets/custom_app_bar.dart';
import '../../shared/widgets/empty_state.dart';
import '../../shared/widgets/profit_loss_check.dart';
import 'holding_data.dart';
import 'portfolio_vm.dart';

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({super.key});

  void _openFilterSheet(BuildContext context) {
    final vm = context.read<PortfolioVm>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => SortBottomSheet(
        selectedSort: vm.selectedSort,
        direction: vm.sortDirection,
        onSelected: vm.updateSort,
        onClear: () {
          vm.updateSort(SortBy.name, SortDirection.ascending);
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(title: 'Portfolio'),
      ),
      body: Consumer<PortfolioVm>(
        builder: (_, vm, __) {
          return UiStateBuilder<List<HoldingData>>(
            uiState: vm.holdingsState,
            onSuccess: (_) => RefreshIndicator(
              color: colorScheme.primary,
              onRefresh: vm.fetchHoldings,
              child: Column(
                children: [
                  SearchAndSort(onFilterTap: () => _openFilterSheet(context)),
                  if (vm.sortedFilteredHoldings.isEmpty)
                    Expanded(
                      child: EmptyState(
                        searchQuery: vm.searchText.isNotEmpty ? vm.searchText : null,
                        emptyMessage: 'No holdings available',
                        onClearSearch: vm.searchText.isNotEmpty ? () => vm.updateSearch('') : null,
                      ),
                    )
                  else
                    Expanded(
                      child: ListView.builder(
                        itemCount: vm.sortedFilteredHoldings.length,
                        itemBuilder: (_, i) => HoldingTile(holding: vm.sortedFilteredHoldings[i]),
                      ),
                    ),
                  if (vm.sortedFilteredHoldings.isNotEmpty)
                    PortfolioSummary(
                      currValue: vm.currValue,
                      currInvest: vm.currInvest,
                      todayPnL: vm.todayPnL,
                      totalPnL: vm.totalPnL,
                    ),
                ],
              ),
            ),
            onRetry: vm.fetchHoldings,
            showRetryOnEmpty: true,
          );
        },
      ),
    );
  }
}

class HoldingTile extends StatelessWidget {
  final HoldingData holding;

  const HoldingTile({super.key, required this.holding});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: colorScheme.outlineVariant,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // First row - Symbol and LTP
            Row(
              children: [
                Text(
                  holding.symbol,
                  style: AppTypography.titleMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                ),
                const Spacer(),
                Text(
                  "LTP: ",
                  style: AppTypography.bodyMedium.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                Text(
                  "\u{20B9}${holding.ltp.formatCurrency()}",
                  style: AppTypography.bodyMedium.copyWith(
                    fontWeight: FontWeight.w500,
                    color: colorScheme.onSurface,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Second row - Quantity and P&L
            Row(
              children: [
                Text(
                  "Qty: ${holding.quantity}",
                  style: AppTypography.bodyMedium.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                const Spacer(),
                Text(
                  "P&L: ",
                  style: AppTypography.bodyMedium.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                ProfitLossCheck(
                  value: holding.pnl,
                  highLightedText: "\u{20B9}${holding.pnl.formatCurrency()}",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
