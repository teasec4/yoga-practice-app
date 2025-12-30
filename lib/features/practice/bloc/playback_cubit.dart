import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yoga_coach/features/practice/data/repositories/practice_repository.dart';
import 'package:yoga_coach/features/practice/domain/entities/practice.dart';
import 'package:yoga_coach/features/practice/domain/repositories/practice_repo.dart';

abstract class PlaybackState {}

class PlaybackInitial extends PlaybackState {}

class PlaybackLoading extends PlaybackState {}

class PlaybackLoaded extends PlaybackState {
  final List<Movement> movements;
  final int currentIndex;
  final int durationMultiplier;

  PlaybackLoaded({
    required this.movements,
    required this.currentIndex,
    required this.durationMultiplier,
  });
}

class PlaybackFinished extends PlaybackState {}

class PlaybackError extends PlaybackState {
  final String message;

  PlaybackError(this.message);
}

class PlaybackCubit extends Cubit<PlaybackState> {
  final String practiceId;
  final PracticeRepo repository;

  PlaybackCubit({required this.practiceId, required this.repository})
    : super(PlaybackInitial()) {
    _loadMovements();
  }

  Future<void> _loadMovements() async {
    emit(PlaybackLoading());
    try {
      final practice = await repository.getPracticeById(practiceId);
      if (practice != null) {
        emit(
          PlaybackLoaded(
            movements: practice.movements,
            currentIndex: 0,
            durationMultiplier: practice.durationMultiplier.value,
          ),
        );
      } else {
        emit(PlaybackError('Practice not found'));
      }
    } catch (e) {
      emit(PlaybackError('Failed to load movements'));
    }
  }

  void nextMovement() {
    if (state is PlaybackLoaded) {
      final currentState = state as PlaybackLoaded;
      if (currentState.currentIndex < currentState.movements.length - 1) {
        emit(
          PlaybackLoaded(
            movements: currentState.movements,
            currentIndex: currentState.currentIndex + 1,
            durationMultiplier: currentState.durationMultiplier,
          ),
        );
      } else {
        emit(PlaybackFinished());
      }
    }
  }

  void selectMovement(int index) {
    if (state is PlaybackLoaded) {
      final currentState = state as PlaybackLoaded;
      emit(
        PlaybackLoaded(
          movements: currentState.movements,
          currentIndex: index,
          durationMultiplier: currentState.durationMultiplier,
        ),
      );
    }
  }
}
