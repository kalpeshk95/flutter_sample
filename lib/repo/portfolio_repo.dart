import 'package:flutter_sample/data/remote/api_service.dart';

import '../data/remote/model/holding/holding_response.dart';
import '../data/remote/network_exception.dart';
import '../data/remote/network_response.dart';

abstract interface class PortfolioRepo {
  Future<NetworkResponse<HoldingResponse>> getUsers();
}

class UserRepoImpl extends PortfolioRepo {
  final ApiService _apiService = ApiService(
      baseUrl: 'https://35dee773a9ec441e9f38d5fc249406ce.api.mockbin.io/');

  @override
  Future<NetworkResponse<HoldingResponse>> getUsers() async {
    try {
      final response = await _apiService.getRequest('/');
      final HoldingResponse holding = holdingResponseFromJson(response.data);
      return NetworkResponse.success(data: holding);
    } catch (e) {
      return NetworkResponse.error(
          NetworkExceptions.getDioException(e).toString());
    }
  }
}
