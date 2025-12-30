import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yoga_coach/features/practice/domain/entities/practice.dart';
import 'package:yoga_coach/features/practice/domain/repositories/practice_repo.dart';

sealed class PracticeState {}

class PracticeInitial extends PracticeState {}

class PracticeLoading extends PracticeState {}

class PracticeLoaded extends PracticeState {
  final List<Practice> practices;
  PracticeLoaded(this.practices);
}

class PracticeDetailLoaded extends PracticeState {
  final Practice practice;
  PracticeDetailLoaded(this.practice);
}

class PracticeError extends PracticeState {
  final String errorMessage;
  PracticeError(this.errorMessage);
}

class PracticeUpdated extends PracticeState {
  final List<Practice> practices;
  PracticeUpdated(this.practices);
}

class PracticeBloc extends Cubit<PracticeState> {
  final PracticeRepo practiceRepo;

  PracticeBloc(this.practiceRepo) : super(PracticeInitial());

  Future<void> getAllPractices() async {
    emit(PracticeLoading());
    try {
      final practices = await practiceRepo.getAllPractices();
      emit(PracticeLoaded(practices));
    } catch (e) {
      emit(PracticeError("Has an error"));
    }
  }

  Future<void> getPracticeById(String id) async {
    emit(PracticeLoading());
    try {
      final practice = await practiceRepo.getPracticeById(id);
      if (practice != null) {
        emit(PracticeDetailLoaded(practice));
      } else {
        emit(PracticeError("Practice not found"));
      }
    } catch (e) {
      emit(PracticeError("Has an error"));
    }
  }

  Future<void> addPractice(Practice practice) async {
    try {
      await practiceRepo.savePractice(practice);
      getAllPractices();
    } catch (e) {
      emit(PracticeError("Has an error while adding practice"));
    }
  }

  Future<void> updatePractice(Practice practice) async {
    try {
      await practiceRepo.updatePractice(practice);
      getAllPractices();
    } catch (e) {
      emit(PracticeError("Has an error while updating practice"));
    }
  }

  Future<void> deletePractice(String id) async {
    try {
      await practiceRepo.deletePractice(id);
      getAllPractices();
    } catch (e) {
      emit(PracticeError("Has an error while deleting practice"));
    }
  }
}
