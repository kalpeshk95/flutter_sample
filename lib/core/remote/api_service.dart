import 'package:dio/dio.dart';

class ApiService {
  static ApiService? _instance; // Nullable instance
  final String baseUrl;
  static const Duration timeout = Duration(milliseconds: 1000 * 300);
  final Dio _dio = Dio(BaseOptions(
    receiveTimeout: timeout,
    connectTimeout: timeout,
    sendTimeout: timeout,
  ));

  // Factory constructor to initialize or return existing instance
  factory ApiService({required String baseUrl}) {
    return _instance ??= ApiService._internal(baseUrl);
  }

  ApiService._internal(this.baseUrl) {
    _dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      options.baseUrl = baseUrl;
      return handler.next(options);
    }));
    // _dio.interceptors.add(Logging(_dio));
  }

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
