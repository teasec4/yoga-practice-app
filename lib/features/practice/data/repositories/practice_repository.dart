import 'package:drift/drift.dart' as drift;
import 'package:yoga_coach/features/practice/data/database/drift_database.dart';
import 'package:yoga_coach/features/practice/domain/entities/practice.dart';
import 'package:yoga_coach/features/practice/domain/repositories/practice_repo.dart';

class PracticeRepository implements PracticeRepo {
  final AppDatabase _database;

  PracticeRepository({required AppDatabase database}) : _database = database;

  @override
  Future<List<Practice>> getAllPractices() async {
    final practices = await _database.getAllPractices();
    final result = <Practice>[];

    for (final practice in practices) {
      final movements = await _database.getMovementsByPracticeId(practice.id);
      result.add(_entityToDomain(practice, movements));
    }

    return result;
  }

  @override
  Future<Practice?> getPracticeById(String id) async {
    final practice = await _database.getPracticeById(id);
    if (practice == null) return null;

    final movements = await _database.getMovementsByPracticeId(id);
    return _entityToDomain(practice, movements);
  }

  @override
  Future<void> savePractice(Practice practice) async {
    final practiceCompanion = PracticesCompanion(
      id: drift.Value(practice.id),
      title: drift.Value(practice.title),
      description: drift.Value(practice.description),
      fullDescription: drift.Value(practice.fullDescription),
      difficulty: drift.Value(practice.difficulty.name),
      iconType: drift.Value(practice.iconType?.name),
      createdAt: drift.Value(practice.createdAt),
      durationMultiplier: drift.Value(practice.durationMultiplier.label),
      isCustom: drift.Value(practice.isCustom),
    );

    final movements = practice.movements.asMap().entries.map((entry) {
      final movement = entry.value;
      final index = entry.key;

      return MovementsCompanion(
        id: drift.Value('${practice.id}-$index'),
        practiceId: drift.Value(practice.id),
        name: drift.Value(movement.name),
        description: drift.Value(movement.description),
        durationSeconds: drift.Value(movement.durationSeconds),
        orderIndex: drift.Value(index),
      );
    }).toList();

    await _database.insertPracticeWithMovements(practiceCompanion, movements);
  }

  @override
  Future<void> deletePractice(String id) async {
    await _database.deletePracticeWithMovements(id);
  }

  @override
  Future<void> updatePractice(Practice practice) async {
    await _database.deletePracticeWithMovements(practice.id);
    await savePractice(practice);
  }

  Practice _entityToDomain(
    PracticeEntity practice,
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

    final iconType = practice.iconType != null
        ? IconType.values.firstWhere(
            (i) => i.name == practice.iconType,
            orElse: () => IconType.lotus,
          )
        : null;

    final domainMovements = movements
        .map(
          (m) => Movement(
            id: m.id,
            name: m.name,
            description: m.description,
            durationSeconds: m.durationSeconds,
          ),
        )
        .toList();

    return Practice(
      id: practice.id,
      title: practice.title,
      description: practice.description,
      fullDescription: practice.fullDescription,
      movements: domainMovements,
      createdAt: practice.createdAt,
      difficulty: difficulty,
      durationMultiplier: multiplier,
      iconType: iconType,
      isCustom: practice.isCustom,
    );
  }
}
