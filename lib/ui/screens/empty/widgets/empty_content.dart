import 'package:flutter/material.dart';
import 'package:flutter_sample/core/theme/app_typography.dart';
import 'package:flutter_sample/core/theme/text_style_extensions.dart';

class EmptyContent extends StatelessWidget {

  const EmptyContent({
    required this.message, required this.subtitle, required this.colorScheme, super.key,
    this.actionText,
    this.onActionPressed,
  });
  final String message;
  final String subtitle;
  final String? actionText;
  final VoidCallback? onActionPressed;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          message,
          style: AppTypography.twentyFour.bold.withColor(colorScheme.onSurface),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        _buildSubtitle(),
        if (actionText != null) ...[
          const SizedBox(height: 24),
          _buildActionButton(),
        ],
      ],
    );
  }

  Widget _buildSubtitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        subtitle,
        style: AppTypography.sixteen.withColor(colorScheme.onSurfaceVariant).withOpacity(0.8),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildActionButton() {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 280),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: colorScheme.primary.withValues(alpha: 0.2),
              blurRadius: 15,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: onActionPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: colorScheme.primary,
            foregroundColor: colorScheme.onPrimary,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 0,
          ),
          child: Text(
            actionText!,
            style: AppTypography.sixteen.semiBold.withColor(colorScheme.onPrimary),
          ),
        ),
      ),
    );
  }
}
