// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_database.dart';

// ignore_for_file: type=lint
class $CustomPracticesTable extends CustomPractices
    with TableInfo<$CustomPracticesTable, CustomPracticeEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomPracticesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _difficultyMeta = const VerificationMeta(
    'difficulty',
  );
  @override
  late final GeneratedColumn<String> difficulty = GeneratedColumn<String>(
    'difficulty',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _durationMultiplierMeta =
      const VerificationMeta('durationMultiplier');
  @override
  late final GeneratedColumn<String> durationMultiplier =
      GeneratedColumn<String>(
        'duration_multiplier',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    difficulty,
    durationMultiplier,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'custom_practices';
  @override
  VerificationContext validateIntegrity(
    Insertable<CustomPracticeEntity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('difficulty')) {
      context.handle(
        _difficultyMeta,
        difficulty.isAcceptableOrUnknown(data['difficulty']!, _difficultyMeta),
      );
    } else if (isInserting) {
      context.missing(_difficultyMeta);
    }
    if (data.containsKey('duration_multiplier')) {
      context.handle(
        _durationMultiplierMeta,
        durationMultiplier.isAcceptableOrUnknown(
          data['duration_multiplier']!,
          _durationMultiplierMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_durationMultiplierMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CustomPracticeEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CustomPracticeEntity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      difficulty: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}difficulty'],
      )!,
      durationMultiplier: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}duration_multiplier'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $CustomPracticesTable createAlias(String alias) {
    return $CustomPracticesTable(attachedDatabase, alias);
  }
}

class CustomPracticeEntity extends DataClass
    implements Insertable<CustomPracticeEntity> {
  final String id;
  final String title;
  final String difficulty;
  final String durationMultiplier;
  final DateTime createdAt;
  const CustomPracticeEntity({
    required this.id,
    required this.title,
    required this.difficulty,
    required this.durationMultiplier,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['difficulty'] = Variable<String>(difficulty);
    map['duration_multiplier'] = Variable<String>(durationMultiplier);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  CustomPracticesCompanion toCompanion(bool nullToAbsent) {
    return CustomPracticesCompanion(
      id: Value(id),
      title: Value(title),
      difficulty: Value(difficulty),
      durationMultiplier: Value(durationMultiplier),
      createdAt: Value(createdAt),
    );
  }

  factory CustomPracticeEntity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CustomPracticeEntity(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      difficulty: serializer.fromJson<String>(json['difficulty']),
      durationMultiplier: serializer.fromJson<String>(
        json['durationMultiplier'],
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'difficulty': serializer.toJson<String>(difficulty),
      'durationMultiplier': serializer.toJson<String>(durationMultiplier),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  CustomPracticeEntity copyWith({
    String? id,
    String? title,
    String? difficulty,
    String? durationMultiplier,
    DateTime? createdAt,
  }) => CustomPracticeEntity(
    id: id ?? this.id,
    title: title ?? this.title,
    difficulty: difficulty ?? this.difficulty,
    durationMultiplier: durationMultiplier ?? this.durationMultiplier,
    createdAt: createdAt ?? this.createdAt,
  );
  CustomPracticeEntity copyWithCompanion(CustomPracticesCompanion data) {
    return CustomPracticeEntity(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      difficulty: data.difficulty.present
          ? data.difficulty.value
          : this.difficulty,
      durationMultiplier: data.durationMultiplier.present
          ? data.durationMultiplier.value
          : this.durationMultiplier,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CustomPracticeEntity(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('difficulty: $difficulty, ')
          ..write('durationMultiplier: $durationMultiplier, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, difficulty, durationMultiplier, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CustomPracticeEntity &&
          other.id == this.id &&
          other.title == this.title &&
          other.difficulty == this.difficulty &&
          other.durationMultiplier == this.durationMultiplier &&
          other.createdAt == this.createdAt);
}

class CustomPracticesCompanion extends UpdateCompanion<CustomPracticeEntity> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> difficulty;
  final Value<String> durationMultiplier;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const CustomPracticesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.durationMultiplier = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CustomPracticesCompanion.insert({
    required String id,
    required String title,
    required String difficulty,
    required String durationMultiplier,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       difficulty = Value(difficulty),
       durationMultiplier = Value(durationMultiplier),
       createdAt = Value(createdAt);
  static Insertable<CustomPracticeEntity> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? difficulty,
    Expression<String>? durationMultiplier,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (difficulty != null) 'difficulty': difficulty,
      if (durationMultiplier != null) 'duration_multiplier': durationMultiplier,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CustomPracticesCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<String>? difficulty,
    Value<String>? durationMultiplier,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return CustomPracticesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      difficulty: difficulty ?? this.difficulty,
      durationMultiplier: durationMultiplier ?? this.durationMultiplier,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (difficulty.present) {
      map['difficulty'] = Variable<String>(difficulty.value);
    }
    if (durationMultiplier.present) {
      map['duration_multiplier'] = Variable<String>(durationMultiplier.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomPracticesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('difficulty: $difficulty, ')
          ..write('durationMultiplier: $durationMultiplier, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MovementsTable extends Movements
    with TableInfo<$MovementsTable, MovementEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MovementsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _practiceIdMeta = const VerificationMeta(
    'practiceId',
  );
  @override
  late final GeneratedColumn<String> practiceId = GeneratedColumn<String>(
    'practice_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES custom_practices (id)',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _durationSecondsMeta = const VerificationMeta(
    'durationSeconds',
  );
  @override
  late final GeneratedColumn<int> durationSeconds = GeneratedColumn<int>(
    'duration_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _orderIndexMeta = const VerificationMeta(
    'orderIndex',
  );
  @override
  late final GeneratedColumn<int> orderIndex = GeneratedColumn<int>(
    'order_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    practiceId,
    name,
    description,
    durationSeconds,
    orderIndex,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'movements';
  @override
  VerificationContext validateIntegrity(
    Insertable<MovementEntity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('practice_id')) {
      context.handle(
        _practiceIdMeta,
        practiceId.isAcceptableOrUnknown(data['practice_id']!, _practiceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_practiceIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('duration_seconds')) {
      context.handle(
        _durationSecondsMeta,
        durationSeconds.isAcceptableOrUnknown(
          data['duration_seconds']!,
          _durationSecondsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_durationSecondsMeta);
    }
    if (data.containsKey('order_index')) {
      context.handle(
        _orderIndexMeta,
        orderIndex.isAcceptableOrUnknown(data['order_index']!, _orderIndexMeta),
      );
    } else if (isInserting) {
      context.missing(_orderIndexMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MovementEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MovementEntity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      practiceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}practice_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      durationSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_seconds'],
      )!,
      orderIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order_index'],
      )!,
    );
  }

  @override
  $MovementsTable createAlias(String alias) {
    return $MovementsTable(attachedDatabase, alias);
  }
}

class MovementEntity extends DataClass implements Insertable<MovementEntity> {
  final String id;
  final String practiceId;
  final String name;
  final String description;
  final int durationSeconds;
  final int orderIndex;
  const MovementEntity({
    required this.id,
    required this.practiceId,
    required this.name,
    required this.description,
    required this.durationSeconds,
    required this.orderIndex,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['practice_id'] = Variable<String>(practiceId);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    map['duration_seconds'] = Variable<int>(durationSeconds);
    map['order_index'] = Variable<int>(orderIndex);
    return map;
  }

  MovementsCompanion toCompanion(bool nullToAbsent) {
    return MovementsCompanion(
      id: Value(id),
      practiceId: Value(practiceId),
      name: Value(name),
      description: Value(description),
      durationSeconds: Value(durationSeconds),
      orderIndex: Value(orderIndex),
    );
  }

  factory MovementEntity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MovementEntity(
      id: serializer.fromJson<String>(json['id']),
      practiceId: serializer.fromJson<String>(json['practiceId']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      durationSeconds: serializer.fromJson<int>(json['durationSeconds']),
      orderIndex: serializer.fromJson<int>(json['orderIndex']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'practiceId': serializer.toJson<String>(practiceId),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'durationSeconds': serializer.toJson<int>(durationSeconds),
      'orderIndex': serializer.toJson<int>(orderIndex),
    };
  }

  MovementEntity copyWith({
    String? id,
    String? practiceId,
    String? name,
    String? description,
    int? durationSeconds,
    int? orderIndex,
  }) => MovementEntity(
    id: id ?? this.id,
    practiceId: practiceId ?? this.practiceId,
    name: name ?? this.name,
    description: description ?? this.description,
    durationSeconds: durationSeconds ?? this.durationSeconds,
    orderIndex: orderIndex ?? this.orderIndex,
  );
  MovementEntity copyWithCompanion(MovementsCompanion data) {
    return MovementEntity(
      id: data.id.present ? data.id.value : this.id,
      practiceId: data.practiceId.present
          ? data.practiceId.value
          : this.practiceId,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      durationSeconds: data.durationSeconds.present
          ? data.durationSeconds.value
          : this.durationSeconds,
      orderIndex: data.orderIndex.present
          ? data.orderIndex.value
          : this.orderIndex,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MovementEntity(')
          ..write('id: $id, ')
          ..write('practiceId: $practiceId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('orderIndex: $orderIndex')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    practiceId,
    name,
    description,
    durationSeconds,
    orderIndex,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MovementEntity &&
          other.id == this.id &&
          other.practiceId == this.practiceId &&
          other.name == this.name &&
          other.description == this.description &&
          other.durationSeconds == this.durationSeconds &&
          other.orderIndex == this.orderIndex);
}

class MovementsCompanion extends UpdateCompanion<MovementEntity> {
  final Value<String> id;
  final Value<String> practiceId;
  final Value<String> name;
  final Value<String> description;
  final Value<int> durationSeconds;
  final Value<int> orderIndex;
  final Value<int> rowid;
  const MovementsCompanion({
    this.id = const Value.absent(),
    this.practiceId = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.durationSeconds = const Value.absent(),
    this.orderIndex = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MovementsCompanion.insert({
    required String id,
    required String practiceId,
    required String name,
    required String description,
    required int durationSeconds,
    required int orderIndex,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       practiceId = Value(practiceId),
       name = Value(name),
       description = Value(description),
       durationSeconds = Value(durationSeconds),
       orderIndex = Value(orderIndex);
  static Insertable<MovementEntity> custom({
    Expression<String>? id,
    Expression<String>? practiceId,
    Expression<String>? name,
    Expression<String>? description,
    Expression<int>? durationSeconds,
    Expression<int>? orderIndex,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (practiceId != null) 'practice_id': practiceId,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (durationSeconds != null) 'duration_seconds': durationSeconds,
      if (orderIndex != null) 'order_index': orderIndex,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MovementsCompanion copyWith({
    Value<String>? id,
    Value<String>? practiceId,
    Value<String>? name,
    Value<String>? description,
    Value<int>? durationSeconds,
    Value<int>? orderIndex,
    Value<int>? rowid,
  }) {
    return MovementsCompanion(
      id: id ?? this.id,
      practiceId: practiceId ?? this.practiceId,
      name: name ?? this.name,
      description: description ?? this.description,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      orderIndex: orderIndex ?? this.orderIndex,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (practiceId.present) {
      map['practice_id'] = Variable<String>(practiceId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (durationSeconds.present) {
      map['duration_seconds'] = Variable<int>(durationSeconds.value);
    }
    if (orderIndex.present) {
      map['order_index'] = Variable<int>(orderIndex.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MovementsCompanion(')
          ..write('id: $id, ')
          ..write('practiceId: $practiceId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CustomPracticesTable customPractices = $CustomPracticesTable(
    this,
  );
  late final $MovementsTable movements = $MovementsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    customPractices,
    movements,
  ];
}

typedef $$CustomPracticesTableCreateCompanionBuilder =
    CustomPracticesCompanion Function({
      required String id,
      required String title,
      required String difficulty,
      required String durationMultiplier,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$CustomPracticesTableUpdateCompanionBuilder =
    CustomPracticesCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<String> difficulty,
      Value<String> durationMultiplier,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$CustomPracticesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $CustomPracticesTable,
          CustomPracticeEntity
        > {
  $$CustomPracticesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$MovementsTable, List<MovementEntity>>
  _movementsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.movements,
    aliasName: $_aliasNameGenerator(
      db.customPractices.id,
      db.movements.practiceId,
    ),
  );

  $$MovementsTableProcessedTableManager get movementsRefs {
    final manager = $$MovementsTableTableManager(
      $_db,
      $_db.movements,
    ).filter((f) => f.practiceId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_movementsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CustomPracticesTableFilterComposer
    extends Composer<_$AppDatabase, $CustomPracticesTable> {
  $$CustomPracticesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get durationMultiplier => $composableBuilder(
    column: $table.durationMultiplier,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> movementsRefs(
    Expression<bool> Function($$MovementsTableFilterComposer f) f,
  ) {
    final $$MovementsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.movements,
      getReferencedColumn: (t) => t.practiceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MovementsTableFilterComposer(
            $db: $db,
            $table: $db.movements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CustomPracticesTableOrderingComposer
    extends Composer<_$AppDatabase, $CustomPracticesTable> {
  $$CustomPracticesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get durationMultiplier => $composableBuilder(
    column: $table.durationMultiplier,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CustomPracticesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CustomPracticesTable> {
  $$CustomPracticesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => column,
  );

  GeneratedColumn<String> get durationMultiplier => $composableBuilder(
    column: $table.durationMultiplier,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> movementsRefs<T extends Object>(
    Expression<T> Function($$MovementsTableAnnotationComposer a) f,
  ) {
    final $$MovementsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.movements,
      getReferencedColumn: (t) => t.practiceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MovementsTableAnnotationComposer(
            $db: $db,
            $table: $db.movements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CustomPracticesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CustomPracticesTable,
          CustomPracticeEntity,
          $$CustomPracticesTableFilterComposer,
          $$CustomPracticesTableOrderingComposer,
          $$CustomPracticesTableAnnotationComposer,
          $$CustomPracticesTableCreateCompanionBuilder,
          $$CustomPracticesTableUpdateCompanionBuilder,
          (CustomPracticeEntity, $$CustomPracticesTableReferences),
          CustomPracticeEntity,
          PrefetchHooks Function({bool movementsRefs})
        > {
  $$CustomPracticesTableTableManager(
    _$AppDatabase db,
    $CustomPracticesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CustomPracticesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CustomPracticesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CustomPracticesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> difficulty = const Value.absent(),
                Value<String> durationMultiplier = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CustomPracticesCompanion(
                id: id,
                title: title,
                difficulty: difficulty,
                durationMultiplier: durationMultiplier,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                required String difficulty,
                required String durationMultiplier,
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => CustomPracticesCompanion.insert(
                id: id,
                title: title,
                difficulty: difficulty,
                durationMultiplier: durationMultiplier,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CustomPracticesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({movementsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (movementsRefs) db.movements],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (movementsRefs)
                    await $_getPrefetchedData<
                      CustomPracticeEntity,
                      $CustomPracticesTable,
                      MovementEntity
                    >(
                      currentTable: table,
                      referencedTable: $$CustomPracticesTableReferences
                          ._movementsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$CustomPracticesTableReferences(
                            db,
                            table,
                            p0,
                          ).movementsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.practiceId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$CustomPracticesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CustomPracticesTable,
      CustomPracticeEntity,
      $$CustomPracticesTableFilterComposer,
      $$CustomPracticesTableOrderingComposer,
      $$CustomPracticesTableAnnotationComposer,
      $$CustomPracticesTableCreateCompanionBuilder,
      $$CustomPracticesTableUpdateCompanionBuilder,
      (CustomPracticeEntity, $$CustomPracticesTableReferences),
      CustomPracticeEntity,
      PrefetchHooks Function({bool movementsRefs})
    >;
typedef $$MovementsTableCreateCompanionBuilder =
    MovementsCompanion Function({
      required String id,
      required String practiceId,
      required String name,
      required String description,
      required int durationSeconds,
      required int orderIndex,
      Value<int> rowid,
    });
typedef $$MovementsTableUpdateCompanionBuilder =
    MovementsCompanion Function({
      Value<String> id,
      Value<String> practiceId,
      Value<String> name,
      Value<String> description,
      Value<int> durationSeconds,
      Value<int> orderIndex,
      Value<int> rowid,
    });

final class $$MovementsTableReferences
    extends BaseReferences<_$AppDatabase, $MovementsTable, MovementEntity> {
  $$MovementsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CustomPracticesTable _practiceIdTable(_$AppDatabase db) =>
      db.customPractices.createAlias(
        $_aliasNameGenerator(db.movements.practiceId, db.customPractices.id),
      );

  $$CustomPracticesTableProcessedTableManager get practiceId {
    final $_column = $_itemColumn<String>('practice_id')!;

    final manager = $$CustomPracticesTableTableManager(
      $_db,
      $_db.customPractices,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_practiceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$MovementsTableFilterComposer
    extends Composer<_$AppDatabase, $MovementsTable> {
  $$MovementsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => ColumnFilters(column),
  );

  $$CustomPracticesTableFilterComposer get practiceId {
    final $$CustomPracticesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.practiceId,
      referencedTable: $db.customPractices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomPracticesTableFilterComposer(
            $db: $db,
            $table: $db.customPractices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MovementsTableOrderingComposer
    extends Composer<_$AppDatabase, $MovementsTable> {
  $$MovementsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => ColumnOrderings(column),
  );

  $$CustomPracticesTableOrderingComposer get practiceId {
    final $$CustomPracticesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.practiceId,
      referencedTable: $db.customPractices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomPracticesTableOrderingComposer(
            $db: $db,
            $table: $db.customPractices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MovementsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MovementsTable> {
  $$MovementsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => column,
  );

  $$CustomPracticesTableAnnotationComposer get practiceId {
    final $$CustomPracticesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.practiceId,
      referencedTable: $db.customPractices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomPracticesTableAnnotationComposer(
            $db: $db,
            $table: $db.customPractices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MovementsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MovementsTable,
          MovementEntity,
          $$MovementsTableFilterComposer,
          $$MovementsTableOrderingComposer,
          $$MovementsTableAnnotationComposer,
          $$MovementsTableCreateCompanionBuilder,
          $$MovementsTableUpdateCompanionBuilder,
          (MovementEntity, $$MovementsTableReferences),
          MovementEntity,
          PrefetchHooks Function({bool practiceId})
        > {
  $$MovementsTableTableManager(_$AppDatabase db, $MovementsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MovementsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MovementsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MovementsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> practiceId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<int> durationSeconds = const Value.absent(),
                Value<int> orderIndex = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MovementsCompanion(
                id: id,
                practiceId: practiceId,
                name: name,
                description: description,
                durationSeconds: durationSeconds,
                orderIndex: orderIndex,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String practiceId,
                required String name,
                required String description,
                required int durationSeconds,
                required int orderIndex,
                Value<int> rowid = const Value.absent(),
              }) => MovementsCompanion.insert(
                id: id,
                practiceId: practiceId,
                name: name,
                description: description,
                durationSeconds: durationSeconds,
                orderIndex: orderIndex,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MovementsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({practiceId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (practiceId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.practiceId,
                                referencedTable: $$MovementsTableReferences
                                    ._practiceIdTable(db),
                                referencedColumn: $$MovementsTableReferences
                                    ._practiceIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$MovementsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MovementsTable,
      MovementEntity,
      $$MovementsTableFilterComposer,
      $$MovementsTableOrderingComposer,
      $$MovementsTableAnnotationComposer,
      $$MovementsTableCreateCompanionBuilder,
      $$MovementsTableUpdateCompanionBuilder,
      (MovementEntity, $$MovementsTableReferences),
      MovementEntity,
      PrefetchHooks Function({bool practiceId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CustomPracticesTableTableManager get customPractices =>
      $$CustomPracticesTableTableManager(_db, _db.customPractices);
  $$MovementsTableTableManager get movements =>
      $$MovementsTableTableManager(_db, _db.movements);
}
