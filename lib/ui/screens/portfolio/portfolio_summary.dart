import 'package:flutter/material.dart';
import 'package:flutter_sample/ui/shared/utility/extension.dart';
import 'package:provider/provider.dart';

import '../../shared/widgets/profit_loss_check.dart';
import 'portfolio_vm.dart';

class PortfolioSummary extends StatelessWidget {
  final double currValue;
  final double currInvest;
  final double todayPnL;
  final double totalPnL;

  const PortfolioSummary({
    super.key,
    required this.currValue,
    required this.currInvest,
    required this.todayPnL,
    required this.totalPnL,
  });

  @override
  Widget build(BuildContext context) {
    final isExpanded = context.select<PortfolioVm, bool>((vm) => vm.isExpanded);
    final colorScheme = Theme.of(context).colorScheme;

    final backgroundColor = context.isDarkMode
        ? colorScheme.surfaceContainerHighest.withValues(alpha: 0.8)
        : colorScheme.surfaceContainerHighest.withValues(alpha: 1);
    final borderColor = context.isDarkMode
        ? colorScheme.surfaceContainerHighest.withValues(alpha: 0.5)
        : Colors.grey.shade300;

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border(
          left: BorderSide(color: borderColor),
          right: BorderSide(color: borderColor),
          top: BorderSide(color: borderColor),
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      padding: const EdgeInsets.all(6),
      child: Column(
        children: [
          AnimatedCrossFade(
            firstChild: Column(
              children: [
                SummaryRow(title: "Current Value", value: "\u{20B9} ${currValue.formatCurrency()}"),
                SummaryRow(
                    title: "Total Investment", value: "\u{20B9} ${currInvest.formatCurrency()}"),
                SummaryRow(
                  title: "Today's Profit & Loss",
                  valueWidget: ProfitLossCheck(
                      value: todayPnL, highLightedText: "\u{20B9} ${todayPnL.formatCurrency()}"),
                ),
                const Divider(),
              ],
            ),
            secondChild: const SizedBox.shrink(),
            crossFadeState: isExpanded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            duration: const Duration(milliseconds: 300),
          ),
          InkWell(
            onTap: () => context.read<PortfolioVm>().toggleExpansion(),
            child: SummaryRow(
              title: "Profit & Loss",
              titleWidget: Row(children: [
                const Text("Profit & Loss", style: TextStyle(fontSize: 14)),
                Icon(isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down),
              ]),
              valueWidget: ProfitLossCheck(
                  value: totalPnL, highLightedText: "\u{20B9} ${totalPnL.formatCurrency()}"),
            ),
          ),
        ],
      ),
    );
  }
}

class SummaryRow extends StatelessWidget {
  final String? title;
  final Widget? titleWidget;
  final String? value;
  final Widget? valueWidget;

  const SummaryRow({super.key, this.title, this.titleWidget, this.value, this.valueWidget});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Row(
        children: [
          titleWidget ?? Text(title ?? "", style: const TextStyle(fontSize: 14)),
          const Spacer(),
          valueWidget ?? Text(value ?? "", style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
