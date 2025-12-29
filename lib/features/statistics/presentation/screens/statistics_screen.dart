import 'package:flutter/material.dart';
import '../widgets/workout_section.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final popularWorkouts = [
      {
        'name': 'Morning Yoga',
        'duration': '20 min',
        'icon': Icons.self_improvement,
        'backgroundColor': Color.fromARGB(255, 255, 200, 87).withOpacity(0.15),
        'iconColor': Color.fromARGB(255, 255, 152, 0),
      },
      {
        'name': 'Evening Flow',
        'duration': '30 min',
        'icon': Icons.spa,
        'backgroundColor': Color.fromARGB(255, 76, 175, 80).withOpacity(0.15),
        'iconColor': Color.fromARGB(255, 56, 142, 60),
      },
      {
        'name': 'Power Yoga',
        'duration': '45 min',
        'icon': Icons.fitness_center,
        'backgroundColor': Color.fromARGB(255, 244, 67, 54).withOpacity(0.15),
        'iconColor': Color.fromARGB(255, 211, 47, 47),
      },
    ];

    final newestWorkouts = [
      {
        'name': 'Flexibility',
        'duration': '25 min',
        'icon': Icons.accessibility,
        'backgroundColor': Color.fromARGB(255, 33, 150, 243).withOpacity(0.15),
        'iconColor': Color.fromARGB(255, 13, 110, 253),
      },
      {
        'name': 'Breathing',
        'duration': '15 min',
        'icon': Icons.air,
        'backgroundColor': Color.fromARGB(255, 156, 39, 176).withOpacity(0.15),
        'iconColor': Color.fromARGB(255, 123, 31, 162),
      },
      {
        'name': 'Meditation',
        'duration': '20 min',
        'icon': Icons.self_improvement,
        'backgroundColor': Color.fromARGB(255, 103, 58, 183).withOpacity(0.15),
        'iconColor': Color.fromARGB(255, 63, 81, 181),
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore'),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              Container(
                decoration: BoxDecoration(
                  color: colors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: colors.outline.withOpacity(0.2)),
                  boxShadow: [
                    BoxShadow(
                      color: colors.shadow.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search workouts...',
                    hintStyle: TextStyle(color: colors.outline),
                    prefixIcon: Icon(Icons.search, color: colors.outline),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Popular Section
              WorkoutSection(
                title: 'Popular',
                workouts: popularWorkouts,
                onViewMore: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('See more popular workouts')),
                  );
                },
              ),
              const SizedBox(height: 32),

              // Newest Section
              WorkoutSection(
                title: 'Newest',
                workouts: newestWorkouts,
                onViewMore: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('See more newest workouts')),
                  );
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
