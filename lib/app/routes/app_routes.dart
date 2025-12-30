import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yoga_coach/app/routes/main_shell.dart';
import 'package:yoga_coach/features/me/presentation/screens/settings_screen.dart';
import 'package:yoga_coach/features/practice/domain/entities/practice.dart';
import 'package:yoga_coach/features/practice/presentation/screens/create_practice_screen.dart';
import 'package:yoga_coach/features/practice/presentation/screens/practice_detail_screen.dart';
import 'package:yoga_coach/features/practice/presentation/screens/practice_playback_screen.dart';
import 'package:yoga_coach/features/practice/presentation/screens/practice_screen.dart';
import 'package:yoga_coach/features/me/presentation/screens/me_screen.dart';
import 'package:yoga_coach/features/statistics/presentation/screens/statistics_screen.dart';

final goRouter = GoRouter(
  initialLocation: '/practice',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return MainShell(child: child);
      },
      routes: [
        // Practice List
        GoRoute(
          path: '/practice',
          name: 'practice',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: PracticeScreen()),
          routes: [
            // Create/Edit Practice (Modal)
            GoRoute(
              path: 'create',
              name: 'createPractice',
              pageBuilder: (context, state) {
                final editingPractice = state.extra as Practice?;
                return MaterialPage(
                  fullscreenDialog: true,
                  child: CreatePracticeScreen(editingPractice: editingPractice),
                );
              },
            ),
            // Practice Detail
            GoRoute(
              path: ':id',
              name: 'practiceDetail',
              pageBuilder: (context, state) {
                final practiceId = state.pathParameters['id'] ?? '';
                return NoTransitionPage(
                  child: PracticeDetailScreen(practiceId: practiceId),
                );
              },
              routes: [
                // Practice Playback (Full Screen)
                GoRoute(
                  path: 'playback',
                  name: 'practicePlayback',
                  pageBuilder: (context, state) {
                    final practiceId = state.pathParameters['id'] ?? '';
                    return NoTransitionPage(
                      child: PracticePlaybackScreen(practiceId: practiceId),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
        // Statistics
        GoRoute(
          path: '/statistics',
          name: 'statistics',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: StatisticsScreen()),
        ),
        // Me/Profile
        GoRoute(
          path: '/me',
          name: 'me',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: MeScreen()),
          routes: [
            GoRoute(
              path: "settings",
              name: "settings",
              pageBuilder: (context, state) {
                return MaterialPage(
                  fullscreenDialog: true,
                  child: SettingsScreen(),
                );
            } 
                
            ),
          ]
        ),
      ],
    ),
  ],
);
