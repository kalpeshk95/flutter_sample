import 'package:flutter_sample/ui/portfolio/PortfolioVm.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => PortfolioVm());
}
