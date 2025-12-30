import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:yoga_coach/features/practice/data/repositories/custom_practice_repository.dart';
import 'package:yoga_coach/features/practice/data/database/drift_database.dart';
import 'package:yoga_coach/features/practice/domain/entities/custom_practice.dart';
import 'package:yoga_coach/features/practice/domain/entities/practice.dart' show DifficultyLevel;
import 'package:yoga_coach/features/practice/presentation/widgets/delete_dialog.dart';

class CustomPracticeDetailScreen extends StatelessWidget {
  final String practiceId;

  const CustomPracticeDetailScreen({required this.practiceId, super.key});

  Future<CustomPractice?> _getPractice(String id) async {
    final database = AppDatabase();
    final repository = CustomPracticeRepository(database: database);
    return repository.getPracticeById(id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CustomPractice?>(
      future: _getPractice(practiceId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(title: const Text('Practice Details')),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        final practice = snapshot.data;

        if (practice == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Not Found')),
            body: const Center(child: Text('Тренировка не найдена')),
          );
        }
        
        final colors = Theme.of(context).colorScheme;
        
        // Store practice in a local variable to ensure it's available when button is pressed
        final currentPractice = practice;
        
        return Scaffold(
        appBar: AppBar(
         title: const Text('Practice Details'),
         actions: [
           IconButton(
             icon: const Icon(Icons.edit),
             onPressed: () async {
               final result = await context.push<CustomPractice>(
                 '/practice/create',
                 extra: currentPractice,
               );
               if (result != null && context.mounted) {
                 final database = AppDatabase();
                 final repository = CustomPracticeRepository(database: database);
                 await repository.updatePractice(result);
                 if (context.mounted) {
                   context.pop();
                 }
               }
             },
           ),
           IconButton(
             icon: const Icon(Icons.delete, color: Colors.red),
             onPressed: () => _showDeleteDialog(context, currentPractice),
           ),
         ],
         systemOverlayStyle: SystemUiOverlayStyle(
           statusBarColor: Colors.transparent,
           statusBarBrightness: Theme.of(context).brightness == Brightness.light
               ? Brightness.light
               : Brightness.dark,
           statusBarIconBrightness:
               Theme.of(context).brightness == Brightness.light
               ? Brightness.dark
               : Brightness.light,
         ),
        ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Card
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.purple.shade50,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        Container(
                           width: 80,
                           height: 80,
                           decoration: BoxDecoration(
                             color: Colors.purple.shade100,
                             borderRadius: BorderRadius.circular(16),
                           ),
                           child: Icon(
                             Icons.edit,
                             color: Colors.purple.shade600,
                             size: 48,
                           ),
                         ),
                         const SizedBox(height: 16),
                         Text(
                           currentPractice.title,
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(fontWeight: FontWeight.w700),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        _buildDifficultyBadge(
                          context,
                          colors,
                          currentPractice.difficulty,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Info Cards
                  Row(
                    children: [
                      Expanded(
                        child: _buildInfoCard(
                           context: context,
                           icon: Icons.schedule,
                           label: 'Duration',
                           value: '${currentPractice.durationMinutes} min',
                           colors: colors,
                         ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                         child: _buildInfoCard(
                           context: context,
                           icon: Icons.accessibility,
                           label: 'Poses',
                           value: '${currentPractice.poseCount}',
                           colors: colors,
                         ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),

                  // Poses Section
                  Text(
                    'Poses in sequence',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...currentPractice.movements.asMap().entries.map((entry) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: colors.primary.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: colors.outline.withOpacity(0.15),
                          ),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: colors.primary,
                              child: Text(
                                '${entry.key + 1}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    entry.value.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    entry.value.description,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              '${entry.value.durationSeconds}s',
                              style: Theme.of(context).textTheme.labelSmall
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),

          // Buttons at Bottom
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                border: Border(
                  top: BorderSide(color: colors.outline.withOpacity(0.1)),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Edit and Delete buttons row
                  Row(
                    children: [
                      // Edit Button
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            final result = await context.push<CustomPractice>(
                              '/practice/create',
                              extra: currentPractice,
                            );
                            if (result != null && context.mounted) {
                              final database = AppDatabase();
                              final repository = CustomPracticeRepository(database: database);
                              await repository.updatePractice(result);
                              if (context.mounted) {
                                context.pop();
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colors.primary.withOpacity(0.1),
                            foregroundColor: colors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          icon: const Icon(Icons.edit),
                          label: const Text('Edit'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Delete Button
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => _showDeleteDialog(context, currentPractice),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red.withOpacity(0.1),
                            foregroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          icon: const Icon(Icons.delete),
                          label: const Text('Delete'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Start Practice Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                    onPressed: () {
                      context.push(
                        '/practice/custom/${currentPractice.id}/playback',
                      );
                    },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.play_arrow),
                          const SizedBox(width: 8),
                          Text(
                            'Start Practice',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
      },
    );
  }

  Widget _buildInfoCard({
    required BuildContext context,
    required IconData icon,
    required String label,
    required String value,
    required ColorScheme colors,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.primary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.outline.withOpacity(0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: colors.primary, size: 20),
              const SizedBox(width: 8),
              Text(label, style: Theme.of(context).textTheme.labelSmall),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, CustomPractice practice) {
    showDialog(
      context: context,
      builder: (dialogContext) => DeletePracticeDialog(
        practice: practice,
        onConfirm: () async {
          final database = AppDatabase();
          final repository = CustomPracticeRepository(database: database);
          await repository.deletePractice(practice.id);
          if (context.mounted) {
            // Show success snackbar
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${practice.title} deleted'),
                duration: const Duration(seconds: 2),
              ),
            );
            context.pop();
          }
        },
      ),
    );
  }

  Color _getDifficultyColor(DifficultyLevel level) {
    switch (level) {
      case DifficultyLevel.beginner:
        return const Color(0xFF8BC98D);
      case DifficultyLevel.intermediate:
        return const Color(0xFFE8A655);
      case DifficultyLevel.advanced:
        return const Color(0xFFD4727A);
    }
  }

  String _getDifficultyLabel(DifficultyLevel level) {
    switch (level) {
      case DifficultyLevel.beginner:
        return 'Beginner';
      case DifficultyLevel.intermediate:
        return 'Intermediate';
      case DifficultyLevel.advanced:
        return 'Advanced';
    }
  }

  Widget _buildDifficultyBadge(
    BuildContext context,
    ColorScheme colors,
    DifficultyLevel difficulty,
  ) {
    final difficultyColor = _getDifficultyColor(difficulty);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: difficultyColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        _getDifficultyLabel(difficulty),
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: difficultyColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
