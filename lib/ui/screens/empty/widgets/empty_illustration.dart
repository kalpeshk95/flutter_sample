// lib/ui/screens/empty/widgets/empty_illustration.dart
import 'package:flutter/material.dart';

class EmptyIllustration extends StatelessWidget {
  final IconData icon;
  final ColorScheme colorScheme;

  const EmptyIllustration({
    super.key,
    required this.icon,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.8, end: 1.0),
      duration: const Duration(seconds: 2),
      curve: Curves.easeInOut,
      builder: (context, value, _) {
        return Transform.scale(scale: value, child: _buildIllustration());
      },
    );
  }

  Widget _buildIllustration() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colorScheme.primary.withOpacity(0.1),
            colorScheme.secondary.withOpacity(0.1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Icon(icon, size: 64, color: colorScheme.primary),
    );
  }
}
