import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/remote/model/nifty/nifty_fifty.dart';
import '../../../../core/remote/model/nifty/nifty_fifty_response.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../routing/routes.dart';
import '../../../../ui/shared/widgets/profit_loss_check.dart';

// Convert Datum to NiftyStock
NiftyStock toStock(Datum datum) {
  return NiftyStock(
    symbol: datum.symbol ?? '',
    lastPrice: datum.lastPrice ?? 0,
    change: datum.change ?? 0,
    pChange: datum.pChange ?? 0,
  );
}

class StockItemTile extends StatelessWidget {
  final Datum datum;

  const StockItemTile({
    super.key,
    required this.datum,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final NiftyStock stock = toStock(datum);
    final isPositive = stock.change >= 0;

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
      child: InkWell(
        onTap: () => context.push(Routes.stockDetailPage, extra: datum),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Symbol and Price
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Symbol
                    Text(
                      stock.symbol,
                      style: AppTypography.titleMedium.copyWith(
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurface,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    // Last Price
                    Text(
                      "\u20B9${stock.lastPrice.toStringAsFixed(2)}",
                      style: AppTypography.bodyMedium.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),

              // Price Change and Percentage
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Price Change
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isPositive ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded,
                        size: 16,
                        color: isPositive ? colorScheme.tertiary : colorScheme.error,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        stock.change.toStringAsFixed(2),
                        style: AppTypography.bodyMedium.copyWith(
                          color: isPositive ? colorScheme.tertiary : colorScheme.error,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  // Percentage Change
                  ProfitLossCheck(
                    value: stock.pChange,
                    highLightedText: "${stock.pChange.toStringAsFixed(2)}%",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
