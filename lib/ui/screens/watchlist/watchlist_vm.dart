import 'package:flutter/material.dart';

import '../../../core/remote/model/nifty/nifty_fifty_response.dart';
import '../../../core/remote/utility/api_executor.dart';
import '../../../repo/watchlist_repo.dart';
import '../../shared/utility/ui_state.dart';

class WatchlistVm extends ChangeNotifier {
  final WatchlistRepo _repo;

  var _niftyFiftyList = UiState<List<Datum>>.loading();

  UiState<List<Datum>> get niftyFiftyList => _niftyFiftyList;
  String _searchQuery = '';

  String get searchQuery => _searchQuery;

  void setSearchQuery(String query) {
    _searchQuery = query.toLowerCase();
    notifyListeners();
  }

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

  /// Returns all stocks except the index (priority == 0) sorted by symbol and filtered by search query
  List<Datum> get niftyStocks {
    final data = _niftyFiftyList.data;
    if (data == null || data.isEmpty) return [];

    var stocks = data.where((item) => item.priority == 0).toList();

    // Apply search filter if query is not empty
    if (_searchQuery.isNotEmpty) {
      stocks = stocks
          .where((item) =>
              (item.symbol?.toLowerCase().contains(_searchQuery) ?? false) ||
              (item.identifier?.toLowerCase().contains(_searchQuery) ?? false))
          .toList();
    }

    // Sort by symbol
    stocks.sort((a, b) => (a.symbol ?? '').compareTo(b.symbol ?? ''));
    return stocks;
  }
}
