import 'package:drift/drift.dart' as drift;
import 'package:yoga_coach/features/practice/data/database/drift_database.dart';
import 'package:yoga_coach/features/practice/domain/entities/custom_practice.dart';
import 'package:yoga_coach/features/practice/domain/entities/practice.dart' show Movement, DifficultyLevel;
import 'package:yoga_coach/features/practice/domain/repositories/practice_repo.dart';

class CustomPracticeRepository implements PracticeRepo{
  final AppDatabase _database;

  CustomPracticeRepository({required AppDatabase database}) : _database = database;

  /// Получить все кастомные тренировки
  Future<List<CustomPractice>> getAllPractices() async {
    final practices = await _database.getAllCustomPractices();
    final result = <CustomPractice>[];

    for (final practice in practices) {
      final movements =
          await _database.getMovementsByPracticeId(practice.id);
      result.add(
        _entityToDomain(practice, movements),
      );
    }

    return result;
  }

  /// Получить одну тренировку по ID
  Future<CustomPractice?> getPracticeById(String id) async {
    final practice = await _database.getCustomPracticeById(id);
    if (practice == null) return null;

    final movements = await _database.getMovementsByPracticeId(id);
    return _entityToDomain(practice, movements);
  }

  /// Сохранить новую тренировку
  Future<void> savePractice(CustomPractice practice) async {
    final practiceCompanion = CustomPracticesCompanion(
      id: drift.Value(practice.id),
      title: drift.Value(practice.title),
      difficulty: drift.Value(practice.difficulty.name),
      durationMultiplier: drift.Value(practice.durationMultiplier.label),
      createdAt: drift.Value(practice.createdAt),
    );

    final movements = practice.movements.asMap().entries.map((entry) {
      final movement = entry.value;
      final index = entry.key;

      return MovementsCompanion(
        id: drift.Value('${practice.id}-${index}'),
        practiceId: drift.Value(practice.id),
        name: drift.Value(movement.name),
        description: drift.Value(movement.description),
        durationSeconds: drift.Value(movement.durationSeconds),
        orderIndex: drift.Value(index),
      );
    }).toList();

    await _database.insertPracticeWithMovements(practiceCompanion, movements);
  }

  /// Удалить тренировку
  Future<void> deletePractice(String id) async {
    await _database.deletePracticeWithMovements(id);
  }

  /// Обновить тренировку
  Future<void> updatePractice(CustomPractice practice) async {
    // Удаляем старую тренировку и её движения
    await _database.deletePracticeWithMovements(practice.id);
    // Сохраняем обновленную
    await savePractice(practice);
  }

  /// Конвертировать сущности БД в domain модели
  CustomPractice _entityToDomain(
    CustomPracticeEntity practice,
    List<MovementEntity> movements,
  ) {
    final difficulty = DifficultyLevel.values.firstWhere(
      (d) => d.name == practice.difficulty,
      orElse: () => DifficultyLevel.beginner,
    );

    final multiplier = DurationMultiplier.values.firstWhere(
      (m) => m.label == practice.durationMultiplier,
      orElse: () => DurationMultiplier.x1,
    );

    final domainMovements = movements
        .map((m) => Movement(
          id: m.id,
          name: m.name,
          description: m.description,
          durationSeconds: m.durationSeconds,
        ))
        .toList();

    return CustomPractice(
      id: practice.id,
      title: practice.title,
      movements: domainMovements,
      createdAt: practice.createdAt,
      difficulty: difficulty,
      durationMultiplier: multiplier,
    );
  }
}
