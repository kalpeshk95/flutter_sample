import 'package:flutter_sample/data/remote/api_service.dart';

import '../data/remote/network_exception.dart';
import '../data/remote/network_response.dart';
import 'model/user_details.dart';

abstract interface class NetworkRepo {
  Future<NetworkResponse<List<UserDetails>>> getUsers();
}

class NetworkRepoImpl extends NetworkRepo {
  final ApiService _apiService = ApiService(baseUrl: 'https://35dee773a9ec441e9f38d5fc249406ce.api.mockbin.io');

  @override
  Future<NetworkResponse<List<UserDetails>>> getUsers() async {
    try {
      final response = await _apiService.getRequest('/');
      final List<UserDetails> users = (response as List<dynamic>)
          .map((json) => UserDetails.fromJson(json))
          .toList();
      return NetworkResponse.success(data: users);
    } catch (e) {
      return NetworkResponse.error(
          NetworkExceptions.getDioException(e).toString());
    }
  }
}
