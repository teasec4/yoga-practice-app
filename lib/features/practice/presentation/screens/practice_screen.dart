import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:yoga_coach/features/practice/bloc/practice_bloc.dart';
import 'package:yoga_coach/features/practice/domain/entities/practice.dart';
import 'package:yoga_coach/features/practice/presentation/widgets/delete_dialog.dart';
import 'package:yoga_coach/features/practice/presentation/widgets/practice_tile.dart';

class PracticeScreen extends StatelessWidget {
  const PracticeScreen({super.key});

  void _openCreatePractice(BuildContext context) async {
    final result = await context.push<Practice>('/practice/create');

    if (result != null && context.mounted) {
      context.read<PracticeBloc>().addPractice(result);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Custom practice "${result.title}" created'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void _editPractice(BuildContext context, Practice practice) async {
    final result = await context.push<Practice>(
      '/practice/create',
      extra: practice,
    );

    if (result != null && context.mounted) {
      context.read<PracticeBloc>().updatePractice(result);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${result.title} updated'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void _deletePractice(BuildContext context, Practice practice) {
    showDialog(
      context: context,
      builder: (dialogContext) => DeletePracticeDialog(
        practice: practice,
        onConfirm: () {
          context.read<PracticeBloc>().deletePractice(practice.id);
          Navigator.of(context).pop();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Practice')),
      body: BlocBuilder<PracticeBloc, PracticeState>(
        builder: (context, state) {
          if (state is PracticeLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is PracticeLoaded) {
            final practices = state.practices;
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: practices.length,
              itemBuilder: (context, index) {
                final practice = practices[index];
                return PracticeTile(
                  practice: practice,
                  onTap: () {
                    context.go('/practice/${practice.id}');
                  },
                  onEdit: practice.isCustom
                      ? () => _editPractice(context, practice)
                      : null,
                  onDelete: practice.isCustom
                      ? () => _deletePractice(context, practice)
                      : null,
                );
              },
            );
          }
          if (state is PracticeError) {
            return Center(child: Text(state.errorMessage));
          }
          return const Center(child: Text("No data"));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openCreatePractice(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
