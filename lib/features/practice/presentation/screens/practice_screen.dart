import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yoga_coach/core/data/app_content.dart';
import 'package:yoga_coach/features/practice/domain/entities/custom_practice.dart';
import 'package:yoga_coach/features/practice/data/repositories/custom_practice_repository.dart';
import 'package:yoga_coach/features/practice/data/database/drift_database.dart';
import 'package:yoga_coach/features/practice/presentation/widgets/custom_practice_tile.dart';
import 'package:yoga_coach/features/practice/presentation/widgets/practice_tile.dart';
import 'package:yoga_coach/features/practice/presentation/widgets/delete_dialog.dart';

class PracticeScreen extends StatefulWidget {
  const PracticeScreen({super.key});

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  late CustomPracticeRepository _repository;
  late Future<List<CustomPractice>> _customPracticesFuture;

  @override
  void initState() {
    super.initState();
    final database = AppDatabase();
    _repository = CustomPracticeRepository(database: database);
    _customPracticesFuture = _repository.getAllPractices();
  }

  void _openCreatePractice(BuildContext context) async {
    final result = await context.push<CustomPractice>('/practice/create');

    if (!mounted) return;

    if (result != null) {
      await _repository.savePractice(result);
      if (mounted) {
        setState(() {
          _customPracticesFuture = _repository.getAllPractices();
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Custom practice "${result.title}" created'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }

  void _editPractice(BuildContext context, CustomPractice practice) async {
    final result = await context.push<CustomPractice>(
      '/practice/create',
      extra: practice,
    );

    if (!mounted) return;

    if (result != null) {
      await _repository.updatePractice(result);
      if (mounted) {
        setState(() {
          _customPracticesFuture = _repository.getAllPractices();
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${result.title} updated'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }

  void _deletePractice(BuildContext context, CustomPractice practice) {
    showDialog(
      context: context,
      builder: (dialogContext) => DeletePracticeDialog(
        practice: practice,
        onConfirm: () async {
          await _repository.deletePractice(practice.id);
          if (mounted) {
            setState(() {
              _customPracticesFuture = _repository.getAllPractices();
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${practice.title} deleted'),
                duration: const Duration(seconds: 2),
              ),
            );
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Practice')),
      body: FutureBuilder<List<CustomPractice>>(
        future: _customPracticesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final customPractices = snapshot.data ?? [];

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: standardPractices.length + customPractices.length,
            itemBuilder: (context, index) {
              // Custom practices first
              if (index < customPractices.length) {
                final practice = customPractices[index];
                return CustomPracticeTile(
                  practice: practice,
                  onTap: () {
                    context.go('/practice/custom/${practice.id}');
                  },
                  onEdit: () => _editPractice(context, practice),
                  onDelete: () => _deletePractice(context, practice),
                );
              }

              // Standard practices after
              final practiceIndex = index - customPractices.length;
              final practice = standardPractices[practiceIndex];
              return PracticeTile(
                practice: practice,
                onTap: () {
                  context.go('/practice/${practice.id}');
                },
              );
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
