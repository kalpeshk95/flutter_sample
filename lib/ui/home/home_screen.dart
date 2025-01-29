import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../routing/destination.dart';
import '../../routing/routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: widget.navigationShell,
        bottomNavigationBar: NavigationBar(
          selectedIndex: widget.navigationShell.currentIndex,
          onDestinationSelected: widget.navigationShell.goBranch,
          indicatorColor: Theme.of(context).primaryColor,
          destinations: destinations
              .map(
                (destination) => NavigationDestination(
                  icon: Icon(destination.icon),
                  label: destination.label,
                  selectedIcon: Icon(
                    destination.icon,
                    color: Colors.white,
                  ),
                ),
              )
              .toList(),
        ),
      );

  bool checkRoute() {
    final currentLocation =
        GoRouter.of(context).routerDelegate.currentConfiguration.uri.toString();

    if (currentLocation == Routes.portfolioPage) {
      return true; // Allow the pop to proceed
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          GoRouter.of(context)
              .go(Routes.portfolioPage); // Navigate to the default route
        }
      });
      return false; // Prevent immediate pop
    }
  }
}
