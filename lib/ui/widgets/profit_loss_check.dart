import 'package:flutter/material.dart';

class ProfitLossCheck extends StatelessWidget {
  final double value;
  final String highLightedText;
  final FontWeight fontWeight;
  final double fontSize;

  const ProfitLossCheck({
    super.key,
    required this.value,
    required this.highLightedText,
    this.fontWeight = FontWeight.normal,
    this.fontSize = 14,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      highLightedText,
      style: TextStyle(
          color: value > 0
              ? Colors.green
              : value < 0
                  ? Colors.red
                  : Theme.of(context).textTheme.bodyMedium?.color,
          fontWeight: fontWeight,
          fontSize: fontSize),
    );
  }
}
