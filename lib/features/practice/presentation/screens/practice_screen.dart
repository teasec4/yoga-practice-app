import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yoga_coach/features/practice/data/models/practice_model.dart';
import 'package:yoga_coach/features/practice/presentation/widgets/practice_tile.dart';

enum PracticeType { all, my }

class PracticeScreen extends StatefulWidget {
  const PracticeScreen({super.key});

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  PracticeType _selectedType = PracticeType.all;

  // Mock data for "My Practice" - user created practices
  final List<String> _myPracticeIds = ['1', '5', '10', '2'];

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Practice'),
      ),
      body: Column(
        children: [
          // Custom Segment Switcher
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                color: colors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(4),
              child: Row(
                children: [
                  Expanded(
                    child: _buildSegmentButton(
                      label: 'Default Practice',
                      isSelected: _selectedType == PracticeType.all,
                      onTap: () {
                        setState(() => _selectedType = PracticeType.all);
                      },
                      colors: colors,
                    ),
                  ),
                  Expanded(
                    child: _buildSegmentButton(
                      label: 'My Practice',
                      isSelected: _selectedType == PracticeType.my,
                      onTap: () {
                        setState(() => _selectedType = PracticeType.my);
                      },
                      colors: colors,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Lessons List
          Expanded(
            child: _selectedType == PracticeType.all
                ? _buildPracticeList(mockPractices)
                : _buildPracticeList(
                    mockPractices
                        .where((practice) => _myPracticeIds.contains(practice.id))
                        .toList(),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSegmentButton({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
    required ColorScheme colors,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? colors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: isSelected ? Colors.white : colors.outline,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildPracticeList(List<dynamic> practices) {
    return practices.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.self_improvement,
                  size: 64,
                  color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
                ),
                const SizedBox(height: 16),
                Text(
                  'No practices yet',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  'Create your first yoga practice',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          )
        : ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: practices.length,
            itemBuilder: (context, index) {
              return PracticeTile(
                practice: practices[index],
                onTap: () {
                  context.go('/practice/${practices[index].id}');
                },
              );
            },
          );
  }
}
