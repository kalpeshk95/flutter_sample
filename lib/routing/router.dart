// This code was modified for demo purposes.
import 'package:flutter/cupertino.dart';
import 'package:flutter_sample/routing/routes.dart';
import 'package:go_router/go_router.dart';

import '../ui/db/database_screen.dart';
import '../ui/home/home_screen.dart';
import '../ui/profile/profile_screen.dart';
import '../ui/remote/remote_screen.dart';
import '../ui/setting/setting_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _sectionANavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'sectionANav');

final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: Routes.remotePage,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            HomeScreen(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(navigatorKey: _sectionANavigatorKey, routes: [
            GoRoute(
              path: Routes.remotePage,
              builder: (context, state) => const RemoteScreen(),
            )
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
                path: Routes.databasePage,
                builder: (context, state) => const DatabaseScreen())
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
                path: Routes.profilePage,
                builder: (context, state) => const ProfileScreen(),
                routes: [
                  GoRoute(
                      path: Routes.nestedProfilePage,
                      builder: (context, state) => const SettingScreen())
                ])
          ])
        ],
      )
    ]);
