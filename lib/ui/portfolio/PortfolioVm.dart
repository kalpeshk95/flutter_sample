import 'package:flutter/cupertino.dart';

import '../../repo/portfolio_repo.dart';
import '../utility/ui_state.dart';
import 'holding_data.dart';

class PortfolioVm extends ChangeNotifier {
  final PortfolioRepoImpl _repo = PortfolioRepoImpl();

  UiState<List<HoldingData>> holdingsState = UiState.loading();

  Future<void> fetchHoldings() async {
    holdingsState = UiState.loading();
    notifyListeners();

    final response = await _repo.getHoldings();
    response.when(
      success: (data) {
        holdingsState = UiState.success(toHoldingData(data.data!.userHolding!));
      },
      failure: (e) {
        holdingsState = UiState.error(e.toString());
      },
      loading: (_) {}, // optional
    );
    notifyListeners();
  }
}
