import 'dart:convert';

import '../core/remote/api_service.dart';
import '../core/remote/model/nifty/nifty_fifty_response.dart';
import '../core/remote/utility/error_handler.dart';
import '../core/remote/utility/network_response.dart';

abstract interface class WatchlistRepo {
  Future<NetworkResponse<NiftyFiftyResponse>> getNiftyFiftyList();
}

class WatchlistRepoImpl implements WatchlistRepo {
  final Future<ApiService> _apiService;

  WatchlistRepoImpl(this._apiService);

  @override
  Future<NetworkResponse<NiftyFiftyResponse>> getNiftyFiftyList() async {
    try {
      final api = await _apiService;
      final response = await api.getRequest('equity-stockIndices?index=NIFTY%2050');
      // final response = await rootBundle.loadString('assets/NiftyMock.json');
      final data = json.decode(response.toString());
      final NiftyFiftyResponse niftyFiftyList = NiftyFiftyResponse.fromJson(data);
      return NetworkResponse.success(data: niftyFiftyList);
    } catch (e) {
      final errorMessage = ErrorHandler.getErrorMessage(e);
      return NetworkResponse.error(errorMessage);
    }
  }
}
