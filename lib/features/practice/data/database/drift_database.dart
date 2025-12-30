import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'drift_database.g.dart';

// Tables
@DataClassName('CustomPracticeEntity')
class CustomPractices extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get difficulty => text()(); // beginner, intermediate, advanced
  TextColumn get durationMultiplier => text()(); // x1, x2, x3
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('MovementEntity')
class Movements extends Table {
  TextColumn get id => text()();
  TextColumn get practiceId => text().references(CustomPractices, #id)();
  TextColumn get name => text()();
  TextColumn get description => text()();
  IntColumn get durationSeconds => integer()();
  IntColumn get orderIndex => integer()(); // порядок в тренировке

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [CustomPractices, Movements])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // CustomPractices queries
  Future<List<CustomPracticeEntity>> getAllCustomPractices() {
    return select(customPractices).get();
  }

  Future<CustomPracticeEntity?> getCustomPracticeById(String id) {
    return (select(customPractices)..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
  }

  Future<int> insertCustomPractice(CustomPracticesCompanion practice) {
    return into(customPractices).insert(practice);
  }

  Future<void> deleteCustomPractice(String id) async {
    await (delete(customPractices)..where((tbl) => tbl.id.equals(id))).go();
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
    CustomPracticesCompanion practice,
    List<MovementsCompanion> movementsList,
  ) async {
    await transaction(() async {
      await into(customPractices).insert(practice);
      for (final movement in movementsList) {
        await into(movements).insert(movement);
      }
    });
  }

  Future<void> deletePracticeWithMovements(String practiceId) async {
    await transaction(() async {
      await (delete(movements)..where((tbl) => tbl.practiceId.equals(practiceId)))
          .go();
      await (delete(customPractices)..where((tbl) => tbl.id.equals(practiceId)))
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
