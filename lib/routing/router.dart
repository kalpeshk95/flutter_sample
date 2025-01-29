// This code was modified for demo purposes.
import 'package:flutter/cupertino.dart';
import 'package:flutter_sample/routing/routes.dart';
import 'package:flutter_sample/ui/empty/empty_screen.dart';
import 'package:go_router/go_router.dart';

import '../ui/home/home_screen.dart';
import '../ui/portfolio/portfolio_screen.dart';
import '../ui/setting/setting_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _sectionANavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'sectionANav');

final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: Routes.portfolioPage,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            HomeScreen(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(navigatorKey: _sectionANavigatorKey, routes: [
            GoRoute(
              path: Routes.watchlistPage,
              builder: (context, state) => const EmptyScreen(),
            )
          ]),
          StatefulShellBranch(navigatorKey: _sectionANavigatorKey, routes: [
            GoRoute(
              path: Routes.ordersPage,
              builder: (context, state) => const EmptyScreen(),
            )
          ]),
          StatefulShellBranch(navigatorKey: _sectionANavigatorKey, routes: [
            GoRoute(
              path: Routes.portfolioPage,
              builder: (context, state) => const PortfolioScreen(),
            )
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
                path: Routes.fundsPage,
                builder: (context, state) => const EmptyScreen())
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
                path: Routes.profilePage,
                builder: (context, state) => const EmptyScreen(),
                routes: [
                  GoRoute(
                      path: Routes.nestedProfilePage,
                      builder: (context, state) => const SettingScreen())
                ])
          ])
        ],
      )
    ]);
