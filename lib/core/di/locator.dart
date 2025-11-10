import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../repo/portfolio_repo.dart';
import '../../repo/watchlist_repo.dart';
import '../../ui/screens/portfolio/portfolio_vm.dart';
import '../../ui/screens/watchlist/watchlist_vm.dart';
import '../remote/api_service.dart';

final locator = GetIt.instance;

class _DioFactory {
  static const Duration _timeout = Duration(seconds: 30);

  static Dio create() {
    final dio = Dio(BaseOptions(
      receiveTimeout: _timeout,
      connectTimeout: _timeout,
      sendTimeout: _timeout,
    ));

    return dio
      ..interceptors.addAll([
        LogInterceptor(
          request: true,
          responseBody: true,
          requestBody: true,
          error: true,
        ),
      ]);
  }
}

// Add this new class to manage API clients
class _ApiClients {
  static ApiService? _portfolioApi;
  static ApiService? _watchlistApi;

  static Future<ApiService> get portfolioApi async {
    _portfolioApi ??= ApiService(
      dio: _DioFactory.create(),
      baseUrl: 'https://5aee830d074845b089a674b85b53ebaf.api.mockbin.io',
    );
    return _portfolioApi!;
  }

  static Future<ApiService> get watchlistApi async {
    _watchlistApi ??= ApiService(
      dio: _DioFactory.create(),
      baseUrl: 'https://www.nseindia.com/api/',
    );
    return _watchlistApi!;
  }
}

Future<void> setupLocator() async {
  // Register core dependencies
  _registerCoreDependencies();

  // Register API clients
  _registerApiClients();

  // Register repositories
  _registerRepositories();

  // Register view models
  _registerViewModels();
}

void _registerCoreDependencies() {
  locator.registerLazySingleton<Dio>(_DioFactory.create);
}

void _registerApiClients() {
  // Portfolio API
  locator.registerLazySingleton<Future<ApiService>>(
    () => _ApiClients.portfolioApi,
    instanceName: _ApiServiceKeys.portfolio,
  );

  // Watchlist API
  locator.registerLazySingleton<Future<ApiService>>(
    () => _ApiClients.watchlistApi,
    instanceName: _ApiServiceKeys.watchlist,
  );
}

Future<void> _registerRepositories() async {
  locator.registerFactory<PortfolioRepo>(
    () => PortfolioRepoImpl(
      locator<Future<ApiService>>(instanceName: _ApiServiceKeys.portfolio),
    ),
  );

  locator.registerLazySingleton<WatchlistRepo>(
    () => WatchlistRepoImpl(
      locator<Future<ApiService>>(instanceName: _ApiServiceKeys.watchlist),
    ),
  );
}

void _registerViewModels() {
  locator.registerFactory<PortfolioVm>(
    () => PortfolioVm(locator<PortfolioRepo>()),
  );

  locator.registerFactory<WatchlistVm>(
    () => WatchlistVm(locator<WatchlistRepo>()),
  );
}

abstract class _ApiServiceKeys {
  static const String portfolio = 'portfolioApi';
  static const String watchlist = 'watchlistApi';
}
