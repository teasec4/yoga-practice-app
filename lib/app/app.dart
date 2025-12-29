import 'package:flutter/material.dart';
import 'package:yoga_coach/app/routes/app_routes.dart';
import 'package:yoga_coach/core/theme/app_theme.dart';

class YogaCoachApp extends StatelessWidget {
  const YogaCoachApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Yoga Coach',
      theme: AppTheme.lightTheme(),
      darkTheme: AppTheme.darkTheme(),
      themeMode: ThemeMode.system,
      routerConfig: goRouter,
    );
  }
}
