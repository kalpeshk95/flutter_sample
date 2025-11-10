import 'dart:convert';

import '../core/remote/api_service.dart';
import '../core/remote/model/holding/holding_response.dart';
import '../core/remote/utility/error_handler.dart';
import '../core/remote/utility/network_response.dart';

abstract interface class PortfolioRepo {
  Future<NetworkResponse<HoldingResponse>> getHoldings();
}

class PortfolioRepoImpl implements PortfolioRepo {
  final Future<ApiService> _apiService;

  PortfolioRepoImpl(this._apiService);

  @override
  Future<NetworkResponse<HoldingResponse>> getHoldings() async {
    try {
      final api = await _apiService;
      final response = await api.getRequest('/');
      final HoldingResponse holding = holdingResponseFromJson(jsonEncode(response.data));
      return NetworkResponse.success(data: holding);
    } catch (e) {
      final errorMessage = ErrorHandler.getErrorMessage(e);
      return NetworkResponse.error(errorMessage);
    }
  }
}
