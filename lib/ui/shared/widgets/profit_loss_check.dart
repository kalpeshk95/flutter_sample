import 'package:flutter/material.dart';

import '../../../core/theme/app_typography.dart';

class ProfitLossCheck extends StatelessWidget {
  final double value;
  final String highLightedText;
  final FontWeight fontWeight;
  final double fontSize;

  const ProfitLossCheck({
    super.key,
    required this.value,
    required this.highLightedText,
    this.fontWeight = FontWeight.w500,
    this.fontSize = 14,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    Color getTextColor() {
      if (value > 0) {
        return Colors.green;
      } else if (value < 0) {
        return Colors.red;
      }
      return AppTypography.bodyMedium.color ?? colorScheme.onSurfaceVariant;
    }

    return Text(
      highLightedText,
      style: AppTypography.bodyMedium.copyWith(
        color: getTextColor(),
        fontWeight: fontWeight,
        fontSize: fontSize,
      ),
    );
  }
}
