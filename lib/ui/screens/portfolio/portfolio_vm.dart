import 'package:flutter/cupertino.dart';
import 'package:flutter_sample/ui/screens/portfolio/sort_bottom_sheet.dart';

import '../../../core/remote/model/holding/holding_response.dart';
import '../../../core/remote/utility/api_executor.dart';
import '../../../repo/portfolio_repo.dart';
import '../../shared/utility/ui_state.dart';
import 'holding_data.dart';

class PortfolioVm extends ChangeNotifier {
  final PortfolioRepoImpl _repo;

  UiState<List<HoldingData>> holdingsState = UiState.loading();
  bool isSearching = false;
  String searchText = '';
  SortBy? selectedSort;
  SortDirection sortDirection = SortDirection.none;

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

  void toggleSearch() {
    if (searchText.isNotEmpty) {
      searchText = '';
    } else {
      isSearching = !isSearching;
    }
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

  List<HoldingData> get allHoldings => holdingsState.data ?? [];

  List<HoldingData> get sortedFilteredHoldings {
    List<HoldingData> list = [...allHoldings];

    // Apply search
    if (searchText.isNotEmpty) {
      list = list.where((e) => e.symbol.toLowerCase().contains(searchText.toLowerCase())).toList();
    }

    // Apply sort
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
}
