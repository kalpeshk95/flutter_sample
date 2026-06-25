import 'package:flutter/material.dart';
import 'package:flutter_sample/core/theme/text_style_extensions.dart';

import '../../../core/theme/app_typography.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {

  const CustomAppBar({
    required this.title, super.key,
    this.showBackButton = true,
    this.actions,
    this.onBackPressed,
    this.centerTitle = false,
    this.backgroundColor,
    this.elevation = 0,
    this.titleSpacing = 16,
    this.leading,
    this.toolbarHeight = kToolbarHeight,
  });

  // Predefined styles
  factory CustomAppBar.primary({
    required BuildContext context,
    required String title,
    List<Widget>? actions,
    VoidCallback? onBackPressed,
  }) {
    return CustomAppBar(
      title: title,
      backgroundColor: context.colorScheme.primary,
      elevation: 2,
      actions: actions,
      onBackPressed: onBackPressed,
    );
  }

  factory CustomAppBar.elevated({
    required BuildContext context,
    required String title,
    List<Widget>? actions,
    VoidCallback? onBackPressed,
  }) {
    return CustomAppBar(
      title: title,
      backgroundColor: context.colorScheme.surface,
      elevation: 4,
      actions: actions,
      onBackPressed: onBackPressed,
    );
  }

  factory CustomAppBar.transparent({
    required String title,
    List<Widget>? actions,
    VoidCallback? onBackPressed,
  }) {
    return CustomAppBar(
      title: title,
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: actions,
      onBackPressed: onBackPressed,
    );
  }
  final String title;
  final bool showBackButton;
  final List<Widget>? actions;
  final VoidCallback? onBackPressed;
  final bool centerTitle;
  final Color? backgroundColor;
  final double elevation;
  final double? titleSpacing;
  final Widget? leading;
  final double? toolbarHeight;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return AppBar(
      title: Text(
        title,
        style: AppTypography.twentyTwo.bold.withColor(colorScheme.onSurface),
      ),
      centerTitle: centerTitle,
      backgroundColor: backgroundColor ?? Colors.transparent,
      elevation: elevation,
      titleSpacing: titleSpacing,
      automaticallyImplyLeading: showBackButton,
      leading: showBackButton
          ? (leading ??
              IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: colorScheme.onSurface,
                  size: 20,
                ),
                onPressed: () {
                  if (onBackPressed != null) {
                    onBackPressed!();
                  } else {
                    Navigator.of(context).pop();
                  }
                },
              ))
          : null,
      actions: [
        if (actions != null) ...actions!,
        const SizedBox(width: 8),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight!);
}
