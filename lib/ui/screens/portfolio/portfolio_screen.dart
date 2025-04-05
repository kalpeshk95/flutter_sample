import 'package:flutter/material.dart';
import 'package:flutter_sample/ui/screens/portfolio/portfolio_summary.dart';
import 'package:flutter_sample/ui/shared/utility/extension.dart';
import 'package:provider/provider.dart';

import '../../shared/utility/ui_state.dart';
import '../../shared/widgets/profit_loss_check.dart';
import 'holding_data.dart';
import 'portfolio_vm.dart';

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<PortfolioVm>(
        builder: (context, controller, _) {
          final state = context.watch<PortfolioVm>().holdingsState;

          if (state.status == Status.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == Status.error) {
            return Center(child: Text('Error: ${state.error}'));
          } else if (state.data == null || state.data!.isEmpty) {
            return const Center(child: Text('No Holdings Available'));
          }

          final holdings = state.data!;
          final double currValue =
              holdings.fold(0, (sum, item) => sum + (item.ltp * item.quantity));
          final double currInvest =
              holdings.fold(0, (sum, item) => sum + (item.avgPrice * item.quantity));
          final double todayPnL = holdings.fold(0, (sum, item) => sum + item.pnl);
          final double totalPnL = currValue - currInvest;

          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  itemCount: holdings.length,
                  itemBuilder: (context, index) => HoldingTile(
                    holding: holdings[index],
                  ),
                  separatorBuilder: (_, __) => const Divider(),
                ),
              ),
              PortfolioSummary(
                currValue: currValue,
                currInvest: currInvest,
                todayPnL: todayPnL,
                totalPnL: totalPnL,
              ),
            ],
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
