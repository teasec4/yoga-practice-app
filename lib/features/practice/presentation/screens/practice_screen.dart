import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:yoga_coach/features/practice/bloc/practice_list_cubit.dart';
import 'package:yoga_coach/features/practice/domain/entities/practice.dart';
import 'package:yoga_coach/features/practice/presentation/widgets/delete_dialog.dart';
import 'package:yoga_coach/features/practice/presentation/widgets/practice_tile.dart';

class PracticeScreen extends StatelessWidget {
  const PracticeScreen({super.key});

  void _openCreatePractice(BuildContext context) {
    context.pushNamed('createPractice');
  }

  void _editPractice(BuildContext context, Practice practice) {
    context.pushNamed('createPractice', extra: practice);
  }

  void _deletePractice(BuildContext context, Practice practice) {
    showDialog(
      context: context,
      builder: (dialogContext) => DeletePracticeDialog(
        practice: practice,
        onConfirm: () async {
          await context.read<PracticeListCubit>().deletePractice(practice.id);
          if (context.mounted) {
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
      body: BlocListener<PracticeListCubit, PracticeListState>(
        listener: (context, state) {
          if (state is PracticeListError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 2),
              ),
            );
          }
        },
        child: BlocBuilder<PracticeListCubit, PracticeListState>(
          builder: (context, state) {
            if (state is PracticeListLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is PracticeListLoaded) {
              final practices = state.practices;
              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: practices.length,
                itemBuilder: (context, index) {
                  final practice = practices[index];
                  return PracticeTile(
                    practice: practice,
                    onTap: () {
                      context.pushNamed(
                        'practiceDetail',
                        pathParameters: {'id': practice.id},
                      );
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
            if (state is PracticeListError) {
              return Center(child: Text(state.message));
            }
            return const Center(child: Text("No data"));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openCreatePractice(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
