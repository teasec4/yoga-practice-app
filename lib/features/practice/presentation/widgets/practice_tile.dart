import 'package:flutter/material.dart';
import 'package:yoga_coach/features/practice/domain/entities/practice.dart';

class PracticeTile extends StatelessWidget {
  final Practice practice;
  final VoidCallback? onTap;

  const PracticeTile({
    required this.practice,
    this.onTap,
    super.key,
  });

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
    final colors = Theme.of(context).colorScheme;
    final difficultyColor = _getDifficultyColor(practice.difficulty);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: colors.outline.withOpacity(0.15),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with Icon and Title
                Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: colors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        _getIconData(practice.iconType),
                        color: colors.primary,
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            practice.title,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            practice.description,
                            style: Theme.of(context).textTheme.bodySmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Footer with Duration, Difficulty, and Completed Count
                Row(
                  children: [
                    // Duration
                    Row(
                      children: [
                        Icon(
                          Icons.schedule,
                          size: 16,
                          color: colors.outline,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${practice.durationMinutes} min',
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: colors.outline,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 16),

                    // Difficulty Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: difficultyColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        _getDifficultyLabel(practice.difficulty),
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: difficultyColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const Spacer(),

                    // Completed Count
                    Row(
                      children: [
                        Icon(
                          Icons.people_outline,
                          size: 16,
                          color: colors.outline,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${practice.completedCount}',
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: colors.outline,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
