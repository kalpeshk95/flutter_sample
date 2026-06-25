import '../../../core/remote/model/holding/holding_response.dart';

class HoldingData {

  HoldingData({
    required this.symbol,
    required this.quantity,
    required this.avgPrice,
    required this.ltp,
    required this.pnl,
  });
  final String symbol;
  final int quantity;
  final double avgPrice;
  final double ltp;
  final double pnl;
}

// Convert List<UserHoldingItem> to List<HoldingData>
List<HoldingData> toHoldingData(List<UserHolding> holdings) {
  return holdings.map((item) {
    return HoldingData(
      symbol: item.symbol ?? '',
      quantity: item.quantity ?? 0,
      avgPrice: item.avgPrice ?? 0.0,
      ltp: item.ltp ?? 0.0,
      pnl: getPnL(item),
    );
  }).toList();
}

// Calculate Profit and Loss (PnL)
double getPnL(UserHolding item) {
  final double closePrice = item.close ?? 0.0;
  final double ltp = item.ltp ?? 0.0;
  final int quantity = item.quantity ?? 0;
  return (closePrice - ltp) * quantity;
}
