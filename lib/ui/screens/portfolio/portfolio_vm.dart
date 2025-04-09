import 'package:flutter/cupertino.dart';

import '../../../core/remote/model/holding/holding_response.dart';
import '../../../core/remote/utility/api_executor.dart';
import '../../../repo/portfolio_repo.dart';
import '../../shared/utility/ui_state.dart';
import 'holding_data.dart';

class PortfolioVm extends ChangeNotifier {
  final PortfolioRepoImpl _repo = PortfolioRepoImpl();

  UiState<List<HoldingData>> holdingsState = UiState.loading();

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
}
