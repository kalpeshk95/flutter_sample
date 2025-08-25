import 'package:flutter_sample/repo/watchlist_repo.dart';
import 'package:flutter_sample/ui/screens/wathlist/watchlist_vm.dart';
import 'package:get_it/get_it.dart';

import '../../repo/portfolio_repo.dart';
import '../../repo/user_repo.dart';
import '../../ui/screens/portfolio/portfolio_vm.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<PortfolioRepoImpl>(() => PortfolioRepoImpl());
  locator.registerFactory<PortfolioVm>(() => PortfolioVm(locator<PortfolioRepoImpl>()));

  locator.registerLazySingleton<UserRepoImpl>(() => UserRepoImpl());

  locator.registerLazySingleton<WatchlistRepoImpl>(() => WatchlistRepoImpl());
  locator.registerFactory<WatchlistVm>(() => WatchlistVm(locator<WatchlistRepoImpl>()));
}
