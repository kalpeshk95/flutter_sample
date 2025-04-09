import '../core/remote/api_service.dart';
import '../core/remote/model/user/user_details.dart';
import '../core/remote/utility/error_handler.dart';
import '../core/remote/utility/network_response.dart';

abstract interface class UserRepo {
  Future<NetworkResponse<List<UserDetails>>> getUsers();
}

class UserRepoImpl extends UserRepo {
  final ApiService _apiService =
      ApiService(baseUrl: 'https://35dee773a9ec441e9f38d5fc249406ce.api.mockbin.io');

  @override
  Future<NetworkResponse<List<UserDetails>>> getUsers() async {
    try {
      final response = await _apiService.getRequest('/');
      final List<UserDetails> users = userDetailsFromJson(response.data);
      return NetworkResponse.success(data: users);
    } catch (e) {
      final errorMessage = ErrorHandler.getErrorMessage(e);
      return NetworkResponse.error(errorMessage);
    }
  }
}
