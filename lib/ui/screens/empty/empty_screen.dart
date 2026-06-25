import 'package:flutter/material.dart';
import 'package:flutter_sample/core/theme/text_style_extensions.dart';
import 'package:flutter_sample/ui/screens/empty/widgets/empty_content.dart';
import 'package:flutter_sample/ui/screens/empty/widgets/empty_illustration.dart';

import '../../shared/widgets/custom_app_bar.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({
    super.key,
    this.title,
    this.icon = Icons.inbox_outlined,
    this.message = 'Coming Soon',
    this.subtitle =
        'This feature is under development.\nWe\'re working hard to bring it to you soon!',
    this.actionText,
    this.onActionPressed,
  });

  final String? title;
  final IconData icon;
  final String message;
  final String subtitle;
  final String? actionText;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: CustomAppBar(
          title: title ?? '',
          backgroundColor: Colors.transparent,
          centerTitle: false,
          showBackButton: false,
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                colorScheme.primary.withValues(alpha: 0.05),
                colorScheme.surface,
              ],
            ),
          ),
          child: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    EmptyIllustration(icon: icon, colorScheme: colorScheme),
                    const SizedBox(height: 32),
                    EmptyContent(
                      message: message,
                      subtitle: subtitle,
                      actionText: actionText,
                      onActionPressed: onActionPressed,
                      colorScheme: colorScheme,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
