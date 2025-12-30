import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yoga_coach/features/practice/domain/entities/custom_practice.dart';
import 'package:yoga_coach/features/practice/domain/repositories/practice_repo.dart';

sealed class PracticeState {}

class PracticeInitial extends PracticeState {}

class PracticeLoading extends PracticeState {}

class PracticeLoaded extends PracticeState {
  final List<CustomPractice> practices;
  PracticeLoaded(this.practices);
}



class PracticeError extends PracticeState {
  final String errorMessage;
  PracticeError(this.errorMessage);
}

class PracticeUpdated extends PracticeState {
  final List<CustomPractice> practices;
  PracticeUpdated(this.practices);
}

class PracticeBloc extends Cubit<PracticeState> {
  final PracticeRepo practiceRepo;

  PracticeBloc(this.practiceRepo) : super(PracticeInitial());

  Future<void> getAllPractices() async {
    try {
      final practices = await practiceRepo.getAllPractices();
      if (practices.isNotEmpty) {
        emit(PracticeLoaded(practices));
      }
    } catch (e) {
      emit(PracticeError("Has an error"));
    }
  }
  
  // Future<void> getPracticeById(String id) async{
  //   try{
  //     final practice = await practiceRepo.getPracticeById(id);
  //     emit()
  //   }
  // }
}
