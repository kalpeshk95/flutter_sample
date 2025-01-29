import 'package:flutter_sample/data/remote/api_service.dart';

import '../data/remote/model/user/user_details.dart';
import '../data/remote/network_exception.dart';
import '../data/remote/network_response.dart';

abstract interface class UserRepo {
  Future<NetworkResponse<List<UserDetails>>> getUsers();
}

class UserRepoImpl extends UserRepo {
  final ApiService _apiService = ApiService(
      baseUrl: 'https://35dee773a9ec441e9f38d5fc249406ce.api.mockbin.io');

  @override
  Future<NetworkResponse<List<UserDetails>>> getUsers() async {
    try {
      final response = await _apiService.getRequest('/');
      final List<UserDetails> users = userDetailsFromJson(response.data);
      return NetworkResponse.success(data: users);
    } catch (e) {
      return NetworkResponse.error(
          NetworkExceptions.getDioException(e).toString());
    }
  }
}
