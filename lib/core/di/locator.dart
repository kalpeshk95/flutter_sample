import 'package:flutter_sample/repo/portfolio_repo.dart';
import 'package:flutter_sample/repo/user_repo.dart';
import 'package:flutter_sample/repo/watchlist_repo.dart';
import 'package:flutter_sample/ui/screens/portfolio/portfolio_vm.dart';
import 'package:flutter_sample/ui/screens/watchlist/watchlist_vm.dart';
import 'package:get_it/get_it.dart';

/// Service locator instance
final locator = GetIt.instance;

/// Sets up dependency injection for the application
void setupLocator() {
  // Portfolio related dependencies
  locator
    ..registerLazySingleton<PortfolioRepoImpl>(PortfolioRepoImpl.new)
    ..registerFactory<PortfolioVm>(
      () => PortfolioVm(locator<PortfolioRepoImpl>()),
    );

  // User related dependencies
  locator.registerLazySingleton<UserRepoImpl>(UserRepoImpl.new);

  // Watchlist related dependencies
  locator
    ..registerLazySingleton<WatchlistRepoImpl>(WatchlistRepoImpl.new)
    ..registerFactory<WatchlistVm>(
      () => WatchlistVm(locator<WatchlistRepoImpl>()),
    );
}
