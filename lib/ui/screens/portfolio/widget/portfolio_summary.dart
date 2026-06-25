import 'package:flutter/material.dart';
import 'package:flutter_sample/core/theme/app_typography.dart';
import 'package:flutter_sample/core/theme/text_style_extensions.dart';
import 'package:flutter_sample/ui/shared/utility/extension.dart';
import 'package:provider/provider.dart';

import '../portfolio_vm.dart';

class PortfolioSummary extends StatelessWidget {

  const PortfolioSummary({
    required this.currValue, required this.currInvest, required this.todayPnL, required this.totalPnL, super.key,
  });
  static const double _cardRadius = 16.0;
  static const double _cardPadding = 16.0;
  static const double _iconSize = 20.0;
  static const Duration _animationDuration = Duration(milliseconds: 300);

  final double currValue;
  final double currInvest;
  final double todayPnL;
  final double totalPnL;

  @override
  Widget build(BuildContext context) {
    final isExpanded = context.select<PortfolioVm, bool>((vm) => vm.isExpanded);
    final colorScheme = context.colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildHeader(context, isExpanded, colorScheme),
        _buildContent(context, isExpanded, colorScheme),
        _buildFooter(context, colorScheme),
      ],
    );
  }

  Widget _buildHeader(BuildContext context, bool isExpanded, ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: _cardPadding, vertical: 4),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colorScheme.primary.withOpacity(0.1),
            colorScheme.primary.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(_cardRadius),
          topRight: Radius.circular(_cardRadius),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.assessment_outlined,
            color: colorScheme.primary,
            size: _iconSize,
          ),
          const SizedBox(width: 8),
          Text(
            'Portfolio Summary',
            style: AppTypography.sixteen.semiBold.withColor(colorScheme.onSurface),
          ),
          const Spacer(),
          IconButton(
            icon: Icon(
              isExpanded ? Icons.expand_less : Icons.expand_more,
              color: colorScheme.onSurfaceVariant,
            ),
            onPressed: () => context.read<PortfolioVm>().toggleExpansion(),
            splashRadius: 20,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context, bool isExpanded, ColorScheme colorScheme) {
    return AnimatedSize(
      duration: _animationDuration,
      curve: Curves.easeInOut,
      child: isExpanded
          ? Padding(
              padding: const EdgeInsets.all(_cardPadding),
              child: Column(
                children: [
                  _buildSummaryRow(
                    context,
                    title: 'Current Value',
                    value: currValue,
                    icon: Icons.attach_money_rounded,
                    color: colorScheme.primary,
                  ),
                  const Divider(height: 24, thickness: 1),
                  _buildSummaryRow(
                    context,
                    title: 'Total Investment',
                    value: currInvest,
                    icon: Icons.savings_outlined,
                    color: Colors.blue,
                  ),
                  const Divider(height: 24, thickness: 1),
                  _buildSummaryRow(
                    context,
                    title: "Today's P&L",
                    value: todayPnL,
                    valueColor: todayPnL.getPLColor,
                    icon: todayPnL >= 0 ? Icons.arrow_upward : Icons.arrow_downward,
                    color: todayPnL.getPLColor,
                  ),
                ],
              ),
            )
          : const SizedBox.shrink(),
    );
  }

  Widget _buildFooter(BuildContext context, ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: _cardPadding, vertical: 12),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
      ),
      child: _buildSummaryRow(
        context,
        title: 'Total P&L',
        value: totalPnL,
        valueColor: totalPnL.getPLColor,
        icon: Icons.bar_chart_rounded,
        color: Colors.blue,
      ),
    );
  }

  Widget _buildSummaryRow(
    BuildContext context, {
    required String title,
    required double value,
    IconData? icon,
    Color? color,
    Color? valueColor,
  }) {
    final colorScheme = context.colorScheme;

    return Row(
      children: [
        if (icon != null) ...<Widget>[
          _buildIconContainer(icon, color ?? colorScheme.primary),
          const SizedBox(width: 12),
        ],
        Text(
          title,
          style: AppTypography.sixteen.medium.withColor(colorScheme.primary),
        ),
        const Spacer(),
        Text(
          value.formatCurrency(),
          style: AppTypography.fourteen.medium.withColor(valueColor ?? colorScheme.onSurface),
        ),
      ],
    );
  }

  Widget _buildIconContainer(IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 18, color: color),
    );
  }
}
