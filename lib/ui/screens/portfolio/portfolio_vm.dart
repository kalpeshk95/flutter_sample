import 'package:flutter/material.dart';

import '../../../core/remote/model/holding/holding_response.dart';
import '../../../core/remote/utility/api_executor.dart';
import '../../../repo/portfolio_repo.dart';
import '../../shared/utility/ui_state.dart';
import 'holding_data.dart';
import 'sort_bottom_sheet.dart';

class PortfolioVm extends ChangeNotifier {
  final PortfolioRepoImpl _repo;

  UiState<List<HoldingData>> holdingsState = UiState.loading();
  bool isSearching = false;
  bool _isExpanded = false;
  String searchText = '';
  SortBy? selectedSort;
  SortDirection sortDirection = SortDirection.none;

  bool get isExpanded => _isExpanded;

  List<HoldingData> get allHoldings => holdingsState.data ?? [];

  PortfolioVm(this._repo);

  Future<void> fetchHoldings() async {
    await ApiExecutor.run<HoldingResponse, List<HoldingData>>(
      request: _repo.getHoldings,
      mapData: (response) => toHoldingData(response.data?.userHolding ?? []),
      onStateChanged: (state) {
        holdingsState = state;
        notifyListeners();
      },
    );
  }

  void toggleExpansion() {
    _isExpanded = !_isExpanded;
    notifyListeners();
  }

  void toggleSearch() {
    searchText = isSearching ? '' : searchText;
    isSearching = !isSearching;
    notifyListeners();
  }

  void updateSearch(String value) {
    searchText = value;
    notifyListeners();
  }

  void updateSort(SortBy sortBy, SortDirection direction) {
    selectedSort = direction == SortDirection.none ? null : sortBy;
    sortDirection = direction;
    notifyListeners();
  }

  List<HoldingData> get sortedFilteredHoldings {
    var list = allHoldings;

    if (searchText.isNotEmpty) {
      list = list.where((e) => e.symbol.toLowerCase().contains(searchText.toLowerCase())).toList();
    }

    if (selectedSort != null) {
      final comparator = switch (selectedSort!) {
        SortBy.name => (HoldingData a, HoldingData b) => a.symbol.compareTo(b.symbol),
        SortBy.qty => (HoldingData a, HoldingData b) => a.quantity.compareTo(b.quantity),
        SortBy.ltp => (HoldingData a, HoldingData b) => a.ltp.compareTo(b.ltp),
        SortBy.pnl => (HoldingData a, HoldingData b) => a.pnl.compareTo(b.pnl),
      };
      list.sort(sortDirection == SortDirection.ascending ? comparator : (a, b) => comparator(b, a));
    }

    return list;
  }

  double get currValue => allHoldings.fold(0, (sum, item) => sum + (item.ltp * item.quantity));

  double get currInvest =>
      allHoldings.fold(0, (sum, item) => sum + (item.avgPrice * item.quantity));

  double get todayPnL => allHoldings.fold(0, (sum, item) => sum + item.pnl);

  double get totalPnL => currValue - currInvest;
}
