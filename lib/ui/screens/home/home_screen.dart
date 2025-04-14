import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../routing/destination.dart';
import '../../../routing/routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(48),
            child: Container(
              color: Colors.deepPurple,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              child: Row(
                spacing: 10,
                children: [
                  const Icon(
                    Icons.account_circle_outlined,
                    color: Colors.white,
                  ),
                  Text(
                    destinations[widget.navigationShell.currentIndex].label,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
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
        ),
      );

  bool checkRoute() {
    final currentLocation = GoRouter.of(context).routerDelegate.currentConfiguration.uri.toString();

    if (currentLocation == Routes.portfolioPage) {
      return true; // Allow the pop to proceed
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          GoRouter.of(context).go(Routes.portfolioPage); // Navigate to the default route
        }
      });
      return false; // Prevent immediate pop
    }
  }
}
