import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yoga_coach/features/practice/domain/entities/custom_practice.dart';
import 'package:yoga_coach/features/practice/data/models/custom_practice_storage.dart';
import 'package:yoga_coach/features/practice/data/models/practice_model.dart';
import 'package:yoga_coach/features/practice/presentation/screens/create_custom_practice_screen.dart';
import 'package:yoga_coach/features/practice/presentation/widgets/custom_practice_tile.dart';
import 'package:yoga_coach/features/practice/presentation/widgets/practice_tile.dart';

class PracticeScreen extends StatefulWidget {
  const PracticeScreen({super.key});

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  late CustomPracticeStorage _storage;

  @override
  void initState() {
    super.initState();
    _storage = CustomPracticeStorage();
  }

  void _openCreatePractice(BuildContext context) async {
    final result = await context.push<CustomPractice>(
      '/practice/create',
    );

    if (result != null) {
      setState(() {
        _storage.addPractice(result);
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Custom practice "${result.title}" created'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final customPractices = _storage.customPractices;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Practice'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: mockPractices.length + customPractices.length,
        itemBuilder: (context, index) {
          // Custom practices first
          if (index < customPractices.length) {
            final practice = customPractices[index];
            return CustomPracticeTile(
              practice: practice,
              onTap: () {
                context.go('/practice/${practice.id}');
              },
            );
          }

          // Standard practices after
          final practiceIndex = index - customPractices.length;
          final practice = mockPractices[practiceIndex];
          return PracticeTile(
            practice: practice,
            onTap: () {
              context.go('/practice/${practice.id}');
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openCreatePractice(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
