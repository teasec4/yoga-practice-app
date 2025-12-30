import 'package:yoga_coach/features/practice/domain/entities/practice.dart';

class CustomPractice {
  final String id;
  final String title;
  final List<Movement> movements; // в порядке выбора
  final DateTime createdAt;

  CustomPractice({
    required this.id,
    required this.title,
    required this.movements,
    required this.createdAt,
  });

  /// Общее время в секундах
  int get durationSeconds {
    return movements.fold(0, (sum, movement) => sum + movement.durationSeconds);
  }

  /// Общее время в минутах
  int get durationMinutes => (durationSeconds / 60).ceil();

  /// Количество поз
  int get poseCount => movements.length;
}
