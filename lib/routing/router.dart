import 'package:flutter/cupertino.dart';
import 'package:flutter_sample/routing/routes.dart';
import 'package:flutter_sample/ui/screens/watchlist/watchlist_vm.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../core/di/locator.dart';
import '../core/remote/model/nifty/nifty_fifty_response.dart';
import '../ui/screens/empty/empty_screen.dart';
import '../ui/screens/home/home_screen.dart';
import '../ui/screens/portfolio/portfolio_screen.dart';
import '../ui/screens/portfolio/portfolio_vm.dart';
import '../ui/screens/setting/setting_screen.dart';
import '../ui/screens/watchlist/stock_detail_page.dart';
import '../ui/screens/watchlist/watchlist_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final router =
    GoRouter(navigatorKey: _rootNavigatorKey, initialLocation: Routes.portfolioPage, routes: [
  StatefulShellRoute.indexedStack(
    builder: (context, state, navigationShell) => HomeScreen(navigationShell: navigationShell),
    branches: [
      StatefulShellBranch(routes: [
        GoRoute(
          path: Routes.watchlistPage,
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => locator<WatchlistVm>()..fetchNiftyList(),
            child: const WatchlistScreen(),
          ),
        ),
        GoRoute(
          path: Routes.stockDetailPage,
          builder: (context, state) => StockDetailPage(stock: state.extra as Datum),
        )
      ]),
      StatefulShellBranch(routes: [
        GoRoute(
          path: Routes.ordersPage,
          builder: (context, state) => const EmptyScreen(title: 'Orders'),
        )
      ]),
      StatefulShellBranch(routes: [
        GoRoute(
          path: Routes.portfolioPage,
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => locator<PortfolioVm>()..fetchHoldings(),
            child: const PortfolioScreen(),
          ),
        )
      ]),
      StatefulShellBranch(routes: [
        GoRoute(
            path: Routes.fundsPage, builder: (context, state) => const EmptyScreen(title: 'Funds'))
      ]),
      StatefulShellBranch(routes: [
        GoRoute(
            path: Routes.profilePage,
            builder: (context, state) => const EmptyScreen(title: 'Users'),
            routes: [
              GoRoute(
                  path: Routes.nestedProfilePage,
                  builder: (context, state) => const SettingScreen())
            ])
      ])
    ],
  )
]);
