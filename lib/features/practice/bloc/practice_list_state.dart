part of 'practice_list_cubit.dart';

sealed class PracticeListState {}

class PracticeListInitial extends PracticeListState {}

class PracticeListLoading extends PracticeListState {}

class PracticeListLoaded extends PracticeListState {
  final List<Practice> practices;
  
  PracticeListLoaded(this.practices);
}

class PracticeListError extends PracticeListState {
  final String message;
  
  PracticeListError(this.message);
}
