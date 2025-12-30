part of 'practice_detail_cubit.dart';

sealed class PracticeDetailState {}

class PracticeDetailInitial extends PracticeDetailState {}

class PracticeDetailLoading extends PracticeDetailState {}

class PracticeDetailLoaded extends PracticeDetailState {
  final Practice practice;
  
  PracticeDetailLoaded(this.practice);
}

class PracticeDetailError extends PracticeDetailState {
  final String message;
  
  PracticeDetailError(this.message);
}
