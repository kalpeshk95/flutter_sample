import 'package:flutter/material.dart';
import 'package:flutter_sample/ui/utility/extentions.dart';

import '../widgets/profit_loss_check.dart';

class PortfolioSummary extends StatefulWidget {
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
  State<PortfolioSummary> createState() => _PortfolioSummaryState();
}

class _PortfolioSummaryState extends State<PortfolioSummary> {
  bool showDetails = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          left: BorderSide(color: Colors.grey),
          right: BorderSide(color: Colors.grey),
          top: BorderSide(color: Colors.grey),
        ),
        borderRadius: BorderRadius.only(
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
                SummaryRow(
                    title: "Current Value", value: "\u{20B9} ${widget.currValue.formatCurrency()}"),
                SummaryRow(
                    title: "Total Investment",
                    value: "\u{20B9} ${widget.currInvest.formatCurrency()}"),
                SummaryRow(
                  title: "Today's Profit & Loss",
                  valueWidget: ProfitLossCheck(
                      value: widget.todayPnL,
                      highLightedText: "\u{20B9} ${widget.todayPnL.formatCurrency()}"),
                ),
                const Divider(),
              ],
            ),
            secondChild: const SizedBox.shrink(),
            crossFadeState: showDetails ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            duration: const Duration(milliseconds: 300),
          ),
          InkWell(
            onTap: () => setState(() => showDetails = !showDetails),
            child: SummaryRow(
              title: "Profit & Loss",
              titleWidget: Row(children: [
                const Text("Profit & Loss", style: TextStyle(fontSize: 14)),
                Icon(showDetails ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down),
              ]),
              valueWidget: ProfitLossCheck(
                  value: widget.totalPnL,
                  highLightedText: "\u{20B9} ${widget.totalPnL.formatCurrency()}"),
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
