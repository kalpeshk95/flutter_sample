import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/remote/model/nifty/nifty_fifty.dart';
import '../../../../core/remote/model/nifty/nifty_fifty_response.dart';
import '../../../../routing/routes.dart';

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
    final NiftyStock stock = toStock(datum);
    final isPositive = stock.change >= 0;

    return InkWell(
      onTap: () => context.push(Routes.stockDetailPage, extra: datum),
      borderRadius: BorderRadius.circular(12),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Symbol + CMP
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    stock.symbol,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "₹${stock.lastPrice}",
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),

              // Change + %
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Icon(
                        isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                        color: isPositive ? Colors.green : Colors.red,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        stock.change.toStringAsFixed(2),
                        style: TextStyle(
                          color: isPositive ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${stock.pChange.toStringAsFixed(2)}%",
                    style: TextStyle(
                      color: isPositive ? Colors.green : Colors.red,
                      fontSize: 12,
                    ),
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
