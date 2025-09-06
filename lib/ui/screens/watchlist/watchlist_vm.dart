import 'package:flutter/material.dart';

import '../../../core/remote/model/nifty/nifty_fifty_response.dart';
import '../../../core/remote/utility/api_executor.dart';
import '../../../repo/watchlist_repo.dart';
import '../../shared/utility/ui_state.dart';

class WatchlistVm extends ChangeNotifier {
  final WatchlistRepoImpl _repo;
  
  var _niftyFiftyList = UiState<List<Datum>>.loading();
  UiState<List<Datum>> get niftyFiftyList => _niftyFiftyList;

  WatchlistVm(this._repo);

  Future<void> fetchNiftyList() async {
    await ApiExecutor.run<NiftyFiftyResponse, List<Datum>>(
      request: _repo.getNiftyFiftyList,
      mapData: (response) => response.data ?? [],
      onStateChanged: (state) {
        _niftyFiftyList = state;
        notifyListeners();
      },
    );
  }

  /// Returns the Nifty Index (priority == 1)
  Datum? get niftyIndex {
    final data = _niftyFiftyList.data;
    if (data == null) return null;
    
    try {
      return data.firstWhere((item) => item.priority == 1);
    } catch (_) {
      return null;
    }
  }

  /// Returns all stocks except the index (priority == 0) sorted by symbol
  List<Datum> get niftyStocks {
    final data = _niftyFiftyList.data;
    if (data == null || data.isEmpty) return [];
    
    final stocks = data.where((item) => item.priority == 0).toList()
      ..sort((a, b) => (a.symbol ?? '').compareTo(b.symbol ?? ''));
    return stocks;
  }
}
