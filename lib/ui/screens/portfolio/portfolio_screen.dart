import 'package:flutter/material.dart';
import 'package:flutter_sample/ui/screens/portfolio/portfolio_summary.dart';
import 'package:flutter_sample/ui/screens/portfolio/search_and_sort.dart';
import 'package:flutter_sample/ui/screens/portfolio/sort_bottom_sheet.dart';
import 'package:flutter_sample/ui/shared/utility/extension.dart';
import 'package:flutter_sample/ui/shared/widgets/ui_state_builder.dart';
import 'package:provider/provider.dart';

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
    return Scaffold(
      body: Consumer<PortfolioVm>(
        builder: (_, vm, __) {
          return UiStateBuilder<List<HoldingData>>(
            uiState: vm.holdingsState,
            onSuccess: (_) => Column(
              children: [
                SearchAndSort(onFilterTap: () => _openFilterSheet(context)),
                const Divider(height: 1),
                Expanded(
                  child: ListView.separated(
                    itemCount: vm.sortedFilteredHoldings.length,
                    itemBuilder: (_, i) => HoldingTile(holding: vm.sortedFilteredHoldings[i]),
                    separatorBuilder: (_, __) => const Divider(),
                  ),
                ),
                PortfolioSummary(
                  currValue: vm.currValue,
                  currInvest: vm.currInvest,
                  todayPnL: vm.todayPnL,
                  totalPnL: vm.totalPnL,
                ),
              ],
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
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                holding.symbol,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Text(
                "LTP: \u{20B9} ${holding.ltp.formatCurrency()}",
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Text("NET QTY: ${holding.quantity}", style: const TextStyle(fontSize: 14)),
              const Spacer(),
              const Text("P&L: "),
              ProfitLossCheck(
                value: holding.pnl,
                highLightedText: "\u{20B9} ${holding.pnl.formatCurrency()}",
                fontSize: 14,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
