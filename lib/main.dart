import 'package:flutter/material.dart';
import 'package:flutter_sample/core/theme/app_theme.dart';
import 'package:flutter_sample/routing/router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const FinWiseApp());
}

class FinWiseApp extends StatelessWidget {
  const FinWiseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'FinWise - Smart Financial Decisions',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
