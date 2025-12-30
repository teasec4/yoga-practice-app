import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:yoga_coach/features/practice/bloc/practice_bloc.dart';
import 'package:yoga_coach/features/practice/domain/entities/practice.dart';
import 'package:yoga_coach/features/practice/presentation/widgets/delete_dialog.dart';

class PracticeDetailScreen extends StatefulWidget {
  final String practiceId;

  const PracticeDetailScreen({required this.practiceId, super.key});

  @override
  State<PracticeDetailScreen> createState() =>
      _PracticeDetailScreenState();
}

class _PracticeDetailScreenState
    extends State<PracticeDetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PracticeBloc>().getPracticeById(widget.practiceId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PracticeBloc, PracticeState>(
      builder: (context, state) {
        if (state is PracticeLoading) {
          return Scaffold(
            appBar: AppBar(title: const Text('Practice Details')),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        if (state is PracticeDetailLoaded) {
          final practice = state.practice;
          final colors = Theme.of(context).colorScheme;

          return Scaffold(
            appBar: AppBar(
              title: const Text('Practice Details'),
              actions: [
                if (practice.isCustom)
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () async {
                      final result = await context.push<Practice>(
                        '/practice/create',
                        extra: practice,
                      );
                      if (result != null && context.mounted) {
                        context.read<PracticeBloc>().updatePractice(result);
                        context.pop();
                      }
                    },
                  ),
                if (practice.isCustom)
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _showDeleteDialog(context, practice),
                  ),
              ],
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarBrightness:
                    Theme.of(context).brightness == Brightness.light
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
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                                  practice.isCustom ? Icons.edit : Icons.self_improvement,
                                  color: Colors.purple.shade600,
                                  size: 48,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                practice.title,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(fontWeight: FontWeight.w700),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 12),
                              _buildDifficultyBadge(
                                context,
                                colors,
                                practice.difficulty,
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
                                value: '${practice.durationMinutes} min',
                                colors: colors,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildInfoCard(
                                context: context,
                                icon: Icons.accessibility,
                                label: 'Poses',
                                value: '${practice.poseCount}',
                                colors: colors,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 28),

                        // Poses Section
                        Text(
                          'Poses in sequence',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        const SizedBox(height: 12),
                        ...practice.movements.asMap().entries.map((entry) {
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          entry.value.name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w600),
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
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall
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
                    child:
                        // Start Practice Button
                        SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {
                          context.push(
                            '/practice/${practice.id}/playback',
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
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        if (state is PracticeError) {
          return Scaffold(
            appBar: AppBar(title: const Text('Error')),
            body: Center(child: Text(state.errorMessage)),
          );
        }

        return Scaffold(
          appBar: AppBar(title: const Text('Practice Details')),
          body: const Center(child: Text('Something went wrong')),
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

  void _showDeleteDialog(BuildContext context, Practice practice) {
    showDialog(
      context: context,
      builder: (dialogContext) => DeletePracticeDialog(
        practice: practice,
        onConfirm: () {
          context.read<PracticeBloc>().deletePractice(practice.id);
          Navigator.of(context).pop();
          context.go('/practice');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${practice.title} deleted'),
              duration: const Duration(seconds: 2),
            ),
          );
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
