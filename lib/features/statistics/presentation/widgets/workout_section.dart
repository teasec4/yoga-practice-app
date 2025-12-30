import 'package:flutter/material.dart';
import 'workout_card.dart';

class WorkoutSection extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> workouts;
  final VoidCallback onViewMore;

  const WorkoutSection({
    super.key,
    required this.title,
    required this.workouts,
    required this.onViewMore,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),

        // Horizontal List
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: workouts.length,
            itemBuilder: (context, index) {
              final workout = workouts[index];
              return WorkoutCard(
                name: workout['name'] as String,
                duration: workout['duration'] as String,
                icon: workout['icon'] as IconData,
                backgroundColor: workout['backgroundColor'] as Color?,
                iconColor: workout['iconColor'] as Color?,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Selected: ${workout['name']}')),
                  );
                },
              );
            },
          ),
        ),
        const SizedBox(height: 16),

        // View More Button
        Center(
          child: GestureDetector(
            onTap: onViewMore,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                border: Border.all(color: colors.primary),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'View More',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: colors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
