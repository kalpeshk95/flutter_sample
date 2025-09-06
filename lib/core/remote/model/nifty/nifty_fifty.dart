import 'package:flutter_sample/core/remote/model/nifty/nifty_fifty_response.dart';

class NiftyStock {
  final String symbol;
  final double lastPrice;
  final double change;
  final double pChange;

  NiftyStock({
    required this.symbol,
    required this.lastPrice,
    required this.change,
    required this.pChange,
  });
}

// Convert List<UserHoldingItem> to List<HoldingData>
List<NiftyStock> toWatchlist(List<Datum> list) {
  return list.map((item) {
    return NiftyStock(
      symbol: item.symbol ?? "",
      lastPrice: item.lastPrice ?? 0,
      change: item.change ?? 0.0,
      pChange: item.pChange ?? 0.0,
    );
  }).toList();
}

NiftyStock toStock(Datum item) {
  return NiftyStock(
    symbol: item.symbol ?? "",
    lastPrice: item.lastPrice ?? 0,
    change: item.change ?? 0.0,
    pChange: item.pChange ?? 0.0,
  );
}
