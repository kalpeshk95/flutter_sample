import 'package:flutter/material.dart';

import '../../../core/remote/model/nifty/nifty_fifty_response.dart';
import '../../../core/remote/utility/api_executor.dart';
import '../../../repo/watchlist_repo.dart';
import '../../shared/utility/ui_state.dart';

class WatchlistVm extends ChangeNotifier {
  final WatchlistRepoImpl _repo;

  UiState<List<Datum>> niftyFiftyList = UiState.loading();

  WatchlistVm(this._repo);

  Future<void> fetchNiftyList() async {
    await ApiExecutor.run<NiftyFiftyResponse, List<Datum>>(
      request: _repo.getNiftyFiftyList,
      mapData: (response) => response.data ?? [],
      onStateChanged: (state) {
        niftyFiftyList = state;
        notifyListeners();
      },
    );
  }

  /// Returns the Nifty Index (priority == 1)
  Datum? get niftyIndex {
    if (niftyFiftyList.data == null) return null;
    return niftyFiftyList.data!.firstWhere(
      (item) => item.priority == 1,
      orElse: () => Datum(),
    );
  }

  /// Returns all stocks except the index (priority == 0) sorted by symbol
  List<Datum> get niftyStocks {
    if (niftyFiftyList.data == null) return [];
    final stocks = niftyFiftyList.data!.where((item) => item.priority == 0).toList();
    stocks.sort((a, b) => (a.symbol ?? '').compareTo(b.symbol ?? ''));
    return stocks;
  }
}
