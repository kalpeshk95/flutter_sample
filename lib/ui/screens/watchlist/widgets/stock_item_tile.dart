import 'package:flutter/material.dart';
import 'package:flutter_sample/core/remote/model/nifty/nifty_fifty_response.dart';
import 'package:flutter_sample/core/theme/text_style_extensions.dart';
import 'package:flutter_sample/ui/shared/utility/extension.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_typography.dart';
import '../../../../routing/routes.dart';

class StockItemTile extends StatelessWidget {

  const StockItemTile({
    required this.datum, super.key,
  });
  static const _spacing = 16.0;
  static const _smallSpacing = 2.0;
  static const _borderRadius = 16.0;

  final Datum datum;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final isPositive = (datum.change ?? 0) >= 0;
    final changeColor = (datum.change ?? 0).getPLColor;
    final changeIcon = isPositive ? Icons.arrow_upward : Icons.arrow_downward;
    final formattedLastPrice = '\u20B9${datum.lastPrice?.toStringAsFixed(2) ?? '0.00'}';
    final formattedChange =
        '${isPositive ? '+' : ''}${datum.change?.toStringAsFixed(2)} (${datum.pChange?.abs().toStringAsFixed(2)}%)';

    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
      child: InkWell(
        onTap: () => context.push(Routes.stockDetailPage, extra: datum),
        borderRadius: BorderRadius.circular(_borderRadius),
        child: Padding(
          padding: const EdgeInsets.all(_spacing),
          child: _buildContent(
            colorScheme: colorScheme,
            changeColor: changeColor,
            changeIcon: changeIcon,
            formattedLastPrice: formattedLastPrice,
            formattedChange: formattedChange,
          ),
        ),
      ),
    );
  }

  Widget _buildContent({
    required ColorScheme colorScheme,
    required Color changeColor,
    required IconData changeIcon,
    required String formattedLastPrice,
    required String formattedChange,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildStockIcon(colorScheme),
        const SizedBox(width: _spacing),
        _buildStockSymbol(colorScheme),
        const Spacer(),
        _buildStockChange(
          colorScheme: colorScheme,
          changeColor: changeColor,
          changeIcon: changeIcon,
          formattedChange: formattedChange,
          formattedLastPrice: formattedLastPrice,
        ),
      ],
    );
  }

  Widget _buildStockIcon(ColorScheme colorScheme) {
    final symbol = datum.symbol?.isNotEmpty == true ? datum.symbol![0].toUpperCase() : '\u20B9';
    return Container(
      height: 42,
      width: 42,
      decoration: BoxDecoration(
        color: colorScheme.primary.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          symbol,
          style: AppTypography.twentyFour.semiBold.withColor(colorScheme.primary),
        ),
      ),
    );
  }

  Widget _buildStockSymbol(ColorScheme colorScheme) {
    return Text(
      datum.symbol ?? '',
      style: AppTypography.sixteen.semiBold.withColor(colorScheme.onSurface),
    );
  }

  Widget _buildStockChange({
    required ColorScheme colorScheme,
    required Color changeColor,
    required IconData changeIcon,
    required String formattedChange,
    required String formattedLastPrice,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          formattedLastPrice,
          style: AppTypography.fourteen.withColor(colorScheme.onSurface),
        ),
        const SizedBox(height: _smallSpacing),
        Text(
          formattedChange,
          style: AppTypography.twelve.medium.withColor(changeColor),
        )
      ],
    );
  }
}
