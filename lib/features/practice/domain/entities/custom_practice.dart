import 'package:yoga_coach/features/practice/domain/entities/practice.dart';

enum DurationMultiplier {
  x1(1), // Standard
  x2(2), // Double
  x3(3); // Triple

  final int value;
  const DurationMultiplier(this.value);

  String get label => 'x$value';
}

class CustomPractice {
  final String id;
  final String title;
  final List<Movement> movements; // в порядке выбора
  final DateTime createdAt;
  final DifficultyLevel difficulty;
  final DurationMultiplier durationMultiplier; // Множитель времени

  CustomPractice({
    required this.id,
    required this.title,
    required this.movements,
    required this.createdAt,
    this.difficulty = DifficultyLevel.beginner,
    this.durationMultiplier = DurationMultiplier.x1, // По умолчанию x1
  });

  /// Общее время в секундах (с учетом множителя)
  int get durationSeconds {
    final baseDuration = movements.fold(
      0,
      (sum, movement) => sum + movement.durationSeconds,
    );
    return baseDuration * durationMultiplier.value;
  }

  /// Общее время в минутах (с учетом множителя)
  int get durationMinutes => (durationSeconds / 60).ceil();

  /// Количество поз
  int get poseCount => movements.length;
}
