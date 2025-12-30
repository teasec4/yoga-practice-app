import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:yoga_coach/features/practice/domain/entities/practice.dart';
import 'package:yoga_coach/features/practice/domain/entities/custom_practice.dart';
import 'package:yoga_coach/features/practice/data/models/practice_model.dart';
import 'package:yoga_coach/features/practice/data/models/custom_practice_storage.dart';

class PracticeDetailScreen extends StatelessWidget {
  final String practiceId;

  const PracticeDetailScreen({required this.practiceId, super.key});

  dynamic _getPracticeData(String id) {
    // Try standard practices first
    try {
      return mockPractices.firstWhere((p) => p.id == id);
    } catch (e) {
      // Try custom practices
      final storage = CustomPracticeStorage();
      final custom = storage.getPractice(id);
      if (custom != null) {
        return custom;
      }
      // Fallback
      return mockPractices.first;
    }
  }

  bool _isCustomPractice(String id) {
    final storage = CustomPracticeStorage();
    return storage.getPractice(id) != null;
  }

  String _getTitle(dynamic data) {
    if (data is Practice) return data.title;
    if (data is CustomPractice) return data.title;
    return '';
  }

  int _getDurationMinutes(dynamic data) {
    if (data is Practice) return data.durationMinutes;
    if (data is CustomPractice) return data.durationMinutes;
    return 0;
  }

  int _getPoseCount(dynamic data) {
    if (data is Practice) return data.poseCount;
    if (data is CustomPractice) return data.poseCount;
    return 0;
  }

  String _getDescription(dynamic data) {
    if (data is Practice) return data.fullDescription;
    return 'Custom practice created on ${(data as CustomPractice).createdAt.toString().split('.')[0]}';
  }

  int _getCompletedCount(dynamic data) {
    if (data is Practice) return data.completedCount;
    return 0;
  }

  IconType _getIconType(dynamic data) {
    if (data is Practice) return data.iconType;
    return IconType.lotus; // Default for custom
  }

  DifficultyLevel? _getDifficulty(dynamic data) {
    if (data is Practice) return data.difficulty;
    return null;
  }

  IconData _getIconData(IconType type) {
    switch (type) {
      case IconType.lotus:
        return Icons.self_improvement;
      case IconType.tree:
        return Icons.nature;
      case IconType.warrior:
        return Icons.sports_martial_arts;
      case IconType.downward:
        return Icons.trending_down;
      case IconType.meditation:
        return Icons.spa;
      case IconType.breathing:
        return Icons.air;
      case IconType.flexibility:
        return Icons.accessibility;
      case IconType.strength:
        return Icons.fitness_center;
      case IconType.balance:
        return Icons.hub;
      case IconType.relaxation:
        return Icons.cloud;
    }
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

  @override
  Widget build(BuildContext context) {
    final data = _getPracticeData(practiceId);
    final isCustom = _isCustomPractice(practiceId);
    final colors = Theme.of(context).colorScheme;

    // Get difficulty color (only for standard practices)
    Color difficultyColor = const Color(0xFF8BC98D);
    if (data is Practice) {
      difficultyColor = _getDifficultyColor(data.difficulty);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Practice Details'),
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
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  // Header Card
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: colors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: colors.primary.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Icon(
                            _getIconData(_getIconType(data)),
                            color: colors.primary,
                            size: 48,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _getTitle(data),
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(fontWeight: FontWeight.w700),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        if (_getDifficulty(data) != null)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: difficultyColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              _getDifficultyLabel(_getDifficulty(data)!),
                              style: Theme.of(context).textTheme.labelMedium
                                  ?.copyWith(
                                    color: difficultyColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          )
                        else
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: colors.primary.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'Custom',
                              style: Theme.of(context).textTheme.labelMedium
                                  ?.copyWith(
                                    color: colors.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
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
                          value: '${_getDurationMinutes(data)} min',
                          colors: colors,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildInfoCard(
                          context: context,
                          icon: Icons.accessibility,
                          label: 'Poses',
                          value: '${_getPoseCount(data)}',
                          colors: colors,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),

                  // Description Section
                  Text(
                    'About this lesson',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _getDescription(data),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 28),

                  // Stats (only for standard practices)
                  if (_getCompletedCount(data) > 0)
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: colors.outline.withOpacity(0.15),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Icon(Icons.people_outline, color: colors.primary),
                              const SizedBox(height: 8),
                              Text(
                                '${_getCompletedCount(data)}',
                                style: Theme.of(context).textTheme.titleSmall
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                              Text(
                                'Completed',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),

          // Start Button at Bottom
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
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    context.push(
                      '/practice/${practiceId}/playback',
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
            ),
          ),
        ],
      ),
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
}
