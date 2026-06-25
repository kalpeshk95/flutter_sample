import 'package:flutter/material.dart';
import 'package:flutter_sample/core/theme/text_style_extensions.dart';
import 'package:go_router/go_router.dart';

import '../../../routing/destination.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _onDestinationSelected(int index) => widget.navigationShell.goBranch(index);

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Scaffold(
      body: ColoredBox(
        color: colorScheme.surface,
        child: SafeArea(
          bottom: false,
          child: widget.navigationShell,
        ),
      ),
      bottomNavigationBar: _BottomNavBar(
        currentIndex: widget.navigationShell.currentIndex,
        onDestinationSelected: _onDestinationSelected,
        colorScheme: colorScheme,
      ),
    );
  }
}

class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar({
    required this.currentIndex,
    required this.onDestinationSelected,
    required this.colorScheme,
  });

  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: context.colorScheme.onSurfaceVariant.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: onDestinationSelected,
        backgroundColor: colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        indicatorColor: colorScheme.primary,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        destinations: destinations.map((destination) {
          final isSelected = destinations.indexOf(destination) == currentIndex;
          final color = isSelected ? colorScheme.onPrimary : colorScheme.onSurface.withValues(alpha: 0.6);

          return NavigationDestination(
            icon: Icon(destination.icon, color: color),
            label: destination.label,
            selectedIcon: Icon(
              destination.icon,
              color: colorScheme.onPrimary,
            ),
          );
        }).toList(),
      ),
    );
  }
}
