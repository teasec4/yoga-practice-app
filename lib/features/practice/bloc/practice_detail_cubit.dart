import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yoga_coach/features/practice/domain/entities/practice.dart';
import 'package:yoga_coach/features/practice/domain/repositories/practice_repo.dart';

part 'practice_detail_state.dart';

class PracticeDetailCubit extends Cubit<PracticeDetailState> {
  final PracticeRepo _practiceRepo;

  PracticeDetailCubit({required PracticeRepo practiceRepo})
      : _practiceRepo = practiceRepo,
        super(PracticeDetailInitial());

  Future<void> loadPracticeById(String id) async {
    emit(PracticeDetailLoading());
    try {
      final practice = await _practiceRepo.getPracticeById(id);
      if (practice != null) {
        emit(PracticeDetailLoaded(practice));
      } else {
        emit(PracticeDetailError('Practice not found'));
      }
    } catch (e) {
      emit(PracticeDetailError('Failed to load practice'));
    }
  }
}
