import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yoga_coach/features/practice/domain/entities/practice.dart';
import 'package:yoga_coach/features/practice/domain/repositories/practice_repo.dart';

part 'practice_list_state.dart';

class PracticeListCubit extends Cubit<PracticeListState> {
  final PracticeRepo _practiceRepo;

  PracticeListCubit({required PracticeRepo practiceRepo})
      : _practiceRepo = practiceRepo,
        super(PracticeListInitial());

  Future<void> loadPractices() async {
    emit(PracticeListLoading());
    try {
      final practices = await _practiceRepo.getAllPractices();
      emit(PracticeListLoaded(practices));
    } catch (e) {
      emit(PracticeListError('Failed to load practices'));
    }
  }

  Future<void> refreshPractices() async {
    await loadPractices();
  }

  Future<void> addPractice(Practice practice) async {
    try {
      await _practiceRepo.savePractice(practice);
      await loadPractices();
    } catch (e) {
      emit(PracticeListError('Failed to add practice'));
    }
  }

  Future<void> updatePractice(Practice practice) async {
    try {
      await _practiceRepo.updatePractice(practice);
      await loadPractices();
    } catch (e) {
      emit(PracticeListError('Failed to update practice'));
    }
  }

  Future<void> deletePractice(String id) async {
    try {
      await _practiceRepo.deletePractice(id);
      await loadPractices();
    } catch (e) {
      emit(PracticeListError('Failed to delete practice'));
    }
  }
}
