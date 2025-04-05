import 'dart:convert';

import '../core/remote/api_service.dart';
import '../core/remote/model/holding/holding_response.dart';
import '../core/remote/network_exception.dart';
import '../core/remote/network_response.dart';

abstract interface class PortfolioRepo {
  Future<NetworkResponse<HoldingResponse>> getHoldings();
}

class PortfolioRepoImpl extends PortfolioRepo {
  final ApiService _apiService =
      ApiService(baseUrl: 'https://5aee830d074845b089a674b85b53ebaf.api.mockbin.io');

  @override
  Future<NetworkResponse<HoldingResponse>> getHoldings() async {
    try {
      final response = await _apiService.getRequest('/');
      final HoldingResponse holding = holdingResponseFromJson(jsonEncode(response.data));
      return NetworkResponse.success(data: holding);
    } catch (e) {
      return NetworkResponse.error(NetworkExceptions.getDioException(e));
    }
  }
}
