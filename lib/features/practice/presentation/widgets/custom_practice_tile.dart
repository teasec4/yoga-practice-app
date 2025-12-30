import 'package:flutter/material.dart';
import 'package:yoga_coach/features/practice/domain/entities/custom_practice.dart';
import 'package:yoga_coach/features/practice/domain/entities/practice.dart';
import 'package:yoga_coach/features/practice/presentation/widgets/custom_practice_context_menu.dart';

class CustomPracticeTile extends StatelessWidget {
  final CustomPractice practice;
  final VoidCallback onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const CustomPracticeTile({
    required this.practice,
    required this.onTap,
    this.onEdit,
    this.onDelete,
    super.key,
  });

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

  void _showContextMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => CustomPracticeContextMenu(
        practice: practice,
        onEdit: onEdit ?? () {},
        onDelete: onDelete ?? () {},
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.outline.withOpacity(0.15)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          onLongPress: onEdit != null || onDelete != null
              ? () => _showContextMenu(context)
              : null,
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
                        Icons.edit_outlined,
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
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Custom practice',
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

                // Footer with Duration and Poses Count
                Row(
                  children: [
                    // Duration
                    Row(
                      children: [
                        Icon(Icons.schedule, size: 16, color: colors.outline),
                        const SizedBox(width: 4),
                        Text(
                          '${practice.durationMinutes} min',
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(color: colors.outline),
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
                        color: _getDifficultyColor(
                          practice.difficulty,
                        ).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'Custom • ${_getDifficultyLabel(practice.difficulty)}',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: _getDifficultyColor(practice.difficulty),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const Spacer(),

                    // Poses Count
                    Row(
                      children: [
                        Icon(
                          Icons.accessibility,
                          size: 16,
                          color: colors.outline,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${practice.poseCount}',
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(color: colors.outline),
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
