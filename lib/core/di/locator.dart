import 'package:get_it/get_it.dart';

import '../../repo/portfolio_repo.dart';
import '../../repo/user_repo.dart';
import '../../ui/screens/portfolio/portfolio_vm.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => PortfolioVm());
  locator.registerLazySingleton<PortfolioRepoImpl>(() => PortfolioRepoImpl());
  locator.registerLazySingleton<UserRepoImpl>(() => UserRepoImpl());
}
