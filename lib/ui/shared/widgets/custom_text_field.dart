import 'package:flutter/material.dart';
import 'package:flutter_sample/core/theme/text_style_extensions.dart';

import '../../../core/theme/app_typography.dart';

class CustomTextField extends StatelessWidget {

  const CustomTextField({
    required this.controller, required this.label, required this.icon, super.key,
    this.readOnly = false,
    this.keyboardType,
    this.validator,
    this.onTap,
    this.hintText,
    this.maxLines = 1,
    this.maxLength,
    this.obscureText = false,
    this.textInputAction,
    this.onChanged,
    this.textCapitalization = TextCapitalization.none,
    this.contentPadding,
  });
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final bool readOnly;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;
  final String? hintText;
  final int? maxLines;
  final int? maxLength;
  final bool obscureText;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final TextCapitalization textCapitalization;
  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      onTap: onTap,
      keyboardType: keyboardType,
      maxLines: maxLines,
      maxLength: maxLength,
      obscureText: obscureText,
      textInputAction: textInputAction,
      onChanged: onChanged,
      textCapitalization: textCapitalization,
      style: AppTypography.sixteen.withColor(colorScheme.onSurface),
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        labelStyle: TextStyle(color: colorScheme.onSurfaceVariant),
        hintStyle: TextStyle(color: colorScheme.onSurfaceVariant.withOpacity(0.6)),
        prefixIcon: Icon(icon, color: colorScheme.primary),
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest.withOpacity(0.3),
        contentPadding: contentPadding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: _buildBorder(colorScheme.outline),
        enabledBorder: _buildBorder(colorScheme.outline.withOpacity(0.5)),
        focusedBorder: _buildBorder(colorScheme.primary, width: 2),
        errorBorder: _buildBorder(colorScheme.error),
        focusedErrorBorder: _buildBorder(colorScheme.error, width: 2),
        errorStyle: TextStyle(color: colorScheme.error),
        counterText: '',
        suffixIcon: onTap != null && readOnly
            ? Icon(
                Icons.arrow_drop_down,
                color: colorScheme.onSurfaceVariant,
              )
            : null,
      ),
      validator: validator,
    );
  }

  OutlineInputBorder _buildBorder(Color color, {double width = 1.0}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}
