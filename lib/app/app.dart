import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yoga_coach/app/routes/app_routes.dart';
import 'package:yoga_coach/core/di/service_locator.dart';
import 'package:yoga_coach/core/theme/app_theme.dart';
import 'package:yoga_coach/features/practice/bloc/practice_bloc.dart';

class YogaCoachApp extends StatelessWidget {
  const YogaCoachApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PracticeBloc>(
      create: (context) => getIt<PracticeBloc>()..getAllPractices(),
      child: MaterialApp.router(
        title: 'Yoga Coach',
        theme: AppTheme.lightTheme(),
        darkTheme: AppTheme.darkTheme(),
        themeMode: ThemeMode.system,
        routerConfig: goRouter,
      ),
    );
  }
}
