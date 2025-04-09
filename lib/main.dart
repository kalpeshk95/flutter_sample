import 'package:flutter/material.dart';
import 'package:flutter_sample/routing/router.dart';
import 'package:flutter_sample/ui/shared/theme/theme.dart';

import 'core/di/locator.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
    // This is the theme of your application.
  }
}
