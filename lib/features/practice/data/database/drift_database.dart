import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:yoga_coach/core/data/app_content.dart';
import 'package:yoga_coach/features/practice/domain/entities/practice.dart';

part 'drift_database.g.dart';

// Tables
@DataClassName('PracticeEntity')
class Practices extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  TextColumn get fullDescription => text().nullable()();
  TextColumn get difficulty => text()(); // beginner, intermediate, advanced
  TextColumn get iconType => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  TextColumn get durationMultiplier => text()(); // x1, x2, x3
  BoolColumn get isCustom => boolean()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('MovementEntity')
class Movements extends Table {
  TextColumn get id => text()();
  TextColumn get practiceId => text().references(Practices, #id)();
  TextColumn get name => text()();
  TextColumn get description => text()();
  IntColumn get durationSeconds => integer()();
  IntColumn get orderIndex => integer()(); // порядок в тренировке

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [Practices, Movements])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          await _prepopulateStandardPractices();
        },
      );

  Future<void> _prepopulateStandardPractices() async {
    for (final practice in standardPractices) {
      final practiceCompanion = PracticesCompanion(
        id: Value(practice.id),
        title: Value(practice.title),
        description: Value(practice.description),
        fullDescription: Value(practice.fullDescription),
        difficulty: Value(practice.difficulty.name),
        iconType: Value(practice.iconType?.name),
        createdAt: Value(DateTime.now()),
        durationMultiplier: Value(DurationMultiplier.x1.label),
        isCustom: Value(false),
      );
      await into(practices).insert(practiceCompanion);

      for (var i = 0; i < practice.movements.length; i++) {
        final movement = practice.movements[i];
        final movementCompanion = MovementsCompanion(
          id: Value(movement.id),
          practiceId: Value(practice.id),
          name: Value(movement.name),
          description: Value(movement.description),
          durationSeconds: Value(movement.durationSeconds),
          orderIndex: Value(i),
        );
        await into(movements).insert(movementCompanion);
      }
    }
  }

  // Practices queries
  Future<List<PracticeEntity>> getAllPractices() {
    return select(practices).get();
  }

  Future<PracticeEntity?> getPracticeById(String id) {
    return (select(practices)..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
  }

  Future<int> insertPractice(PracticesCompanion practice) {
    return into(practices).insert(practice);
  }

  Future<void> deletePractice(String id) async {
    await (delete(practices)..where((tbl) => tbl.id.equals(id))).go();
  }

  // Movements queries
  Future<List<MovementEntity>> getMovementsByPracticeId(String practiceId) {
    return (select(movements)
          ..where((tbl) => tbl.practiceId.equals(practiceId))
          ..orderBy([(tbl) => OrderingTerm(expression: tbl.orderIndex)]))
        .get();
  }

  Future<int> insertMovement(MovementsCompanion movement) {
    return into(movements).insert(movement);
  }

  Future<void> insertPracticeWithMovements(
    PracticesCompanion practice,
    List<MovementsCompanion> movementsList,
  ) async {
    await transaction(() async {
      await into(practices).insert(practice);
      for (final movement in movementsList) {
        await into(movements).insert(movement);
      }
    });
  }

  Future<void> deletePracticeWithMovements(String practiceId) async {
    await transaction(() async {
      await (delete(movements)..where((tbl) => tbl.practiceId.equals(practiceId)))
          .go();
      await (delete(practices)..where((tbl) => tbl.id.equals(practiceId)))
          .go();
    });
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'app_database.db'));
    return NativeDatabase(
      file,
      logStatements: false,
    );
  });
}