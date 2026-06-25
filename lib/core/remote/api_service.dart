import 'package:dio/dio.dart';

class ApiService {

  ApiService({required Dio dio, required this.baseUrl}) : _dio = dio..options.baseUrl = baseUrl;
  final String baseUrl;
  final Dio _dio;

  Future<Response<T>> getRequest<T>(String url,
      {Map<String, dynamic> queryParam = const {},
      Map<String, dynamic> headers = const {}}) async {
    return await _dio.get(url,
        queryParameters: queryParam, options: Options(headers: headers));
  }

  Future<Response<T>> postRequest<T>(String url,
      {dynamic data,
      Map<String, dynamic> queryParam = const {},
      Map<String, dynamic> headers = const {}}) async {
    return await _dio.post(url,
        data: data,
        queryParameters: queryParam,
        options: Options(headers: headers));
  }
}
