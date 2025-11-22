// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $TodoTable extends Todo with TableInfo<$TodoTable, TodoData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TodoTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
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
  static const VerificationMeta _todoImgMeta = const VerificationMeta(
    'todoImg',
  );
  @override
  late final GeneratedColumn<String> todoImg = GeneratedColumn<String>(
    'todo_img',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<List<String>?, String> tags =
      GeneratedColumn<String>(
        'tags',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<List<String>?>($TodoTable.$convertertagsn);
  static const VerificationMeta _dueDateMeta = const VerificationMeta(
    'dueDate',
  );
  @override
  late final GeneratedColumn<DateTime> dueDate = GeneratedColumn<DateTime>(
    'due_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createAtMeta = const VerificationMeta(
    'createAt',
  );
  @override
  late final GeneratedColumn<DateTime> createAt = GeneratedColumn<DateTime>(
    'create_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now().toUtc(),
  );
  static const VerificationMeta _updateAtMeta = const VerificationMeta(
    'updateAt',
  );
  @override
  late final GeneratedColumn<DateTime> updateAt = GeneratedColumn<DateTime>(
    'update_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now().toUtc(),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    todoImg,
    tags,
    dueDate,
    createAt,
    updateAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'todo';
  @override
  VerificationContext validateIntegrity(
    Insertable<TodoData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('todo_img')) {
      context.handle(
        _todoImgMeta,
        todoImg.isAcceptableOrUnknown(data['todo_img']!, _todoImgMeta),
      );
    }
    if (data.containsKey('due_date')) {
      context.handle(
        _dueDateMeta,
        dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta),
      );
    }
    if (data.containsKey('create_at')) {
      context.handle(
        _createAtMeta,
        createAt.isAcceptableOrUnknown(data['create_at']!, _createAtMeta),
      );
    }
    if (data.containsKey('update_at')) {
      context.handle(
        _updateAtMeta,
        updateAt.isAcceptableOrUnknown(data['update_at']!, _updateAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TodoData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TodoData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      todoImg: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}todo_img'],
      ),
      tags: $TodoTable.$convertertagsn.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}tags'],
        ),
      ),
      dueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}due_date'],
      ),
      createAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}create_at'],
      )!,
      updateAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}update_at'],
      )!,
    );
  }

  @override
  $TodoTable createAlias(String alias) {
    return $TodoTable(attachedDatabase, alias);
  }

  static TypeConverter<List<String>, String> $convertertags =
      const StringListConverter();
  static TypeConverter<List<String>?, String?> $convertertagsn =
      NullAwareTypeConverter.wrap($convertertags);
}

class TodoData extends DataClass implements Insertable<TodoData> {
  final int id;
  final String title;
  final String? todoImg;
  final List<String>? tags;
  final DateTime? dueDate;
  final DateTime createAt;
  final DateTime updateAt;
  const TodoData({
    required this.id,
    required this.title,
    this.todoImg,
    this.tags,
    this.dueDate,
    required this.createAt,
    required this.updateAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || todoImg != null) {
      map['todo_img'] = Variable<String>(todoImg);
    }
    if (!nullToAbsent || tags != null) {
      map['tags'] = Variable<String>($TodoTable.$convertertagsn.toSql(tags));
    }
    if (!nullToAbsent || dueDate != null) {
      map['due_date'] = Variable<DateTime>(dueDate);
    }
    map['create_at'] = Variable<DateTime>(createAt);
    map['update_at'] = Variable<DateTime>(updateAt);
    return map;
  }

  TodoCompanion toCompanion(bool nullToAbsent) {
    return TodoCompanion(
      id: Value(id),
      title: Value(title),
      todoImg: todoImg == null && nullToAbsent
          ? const Value.absent()
          : Value(todoImg),
      tags: tags == null && nullToAbsent ? const Value.absent() : Value(tags),
      dueDate: dueDate == null && nullToAbsent
          ? const Value.absent()
          : Value(dueDate),
      createAt: Value(createAt),
      updateAt: Value(updateAt),
    );
  }

  factory TodoData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TodoData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      todoImg: serializer.fromJson<String?>(json['todoImg']),
      tags: serializer.fromJson<List<String>?>(json['tags']),
      dueDate: serializer.fromJson<DateTime?>(json['dueDate']),
      createAt: serializer.fromJson<DateTime>(json['createAt']),
      updateAt: serializer.fromJson<DateTime>(json['updateAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'todoImg': serializer.toJson<String?>(todoImg),
      'tags': serializer.toJson<List<String>?>(tags),
      'dueDate': serializer.toJson<DateTime?>(dueDate),
      'createAt': serializer.toJson<DateTime>(createAt),
      'updateAt': serializer.toJson<DateTime>(updateAt),
    };
  }

  TodoData copyWith({
    int? id,
    String? title,
    Value<String?> todoImg = const Value.absent(),
    Value<List<String>?> tags = const Value.absent(),
    Value<DateTime?> dueDate = const Value.absent(),
    DateTime? createAt,
    DateTime? updateAt,
  }) => TodoData(
    id: id ?? this.id,
    title: title ?? this.title,
    todoImg: todoImg.present ? todoImg.value : this.todoImg,
    tags: tags.present ? tags.value : this.tags,
    dueDate: dueDate.present ? dueDate.value : this.dueDate,
    createAt: createAt ?? this.createAt,
    updateAt: updateAt ?? this.updateAt,
  );
  TodoData copyWithCompanion(TodoCompanion data) {
    return TodoData(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      todoImg: data.todoImg.present ? data.todoImg.value : this.todoImg,
      tags: data.tags.present ? data.tags.value : this.tags,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      createAt: data.createAt.present ? data.createAt.value : this.createAt,
      updateAt: data.updateAt.present ? data.updateAt.value : this.updateAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TodoData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('todoImg: $todoImg, ')
          ..write('tags: $tags, ')
          ..write('dueDate: $dueDate, ')
          ..write('createAt: $createAt, ')
          ..write('updateAt: $updateAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, todoImg, tags, dueDate, createAt, updateAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TodoData &&
          other.id == this.id &&
          other.title == this.title &&
          other.todoImg == this.todoImg &&
          other.tags == this.tags &&
          other.dueDate == this.dueDate &&
          other.createAt == this.createAt &&
          other.updateAt == this.updateAt);
}

class TodoCompanion extends UpdateCompanion<TodoData> {
  final Value<int> id;
  final Value<String> title;
  final Value<String?> todoImg;
  final Value<List<String>?> tags;
  final Value<DateTime?> dueDate;
  final Value<DateTime> createAt;
  final Value<DateTime> updateAt;
  const TodoCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.todoImg = const Value.absent(),
    this.tags = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.createAt = const Value.absent(),
    this.updateAt = const Value.absent(),
  });
  TodoCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.todoImg = const Value.absent(),
    this.tags = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.createAt = const Value.absent(),
    this.updateAt = const Value.absent(),
  }) : title = Value(title);
  static Insertable<TodoData> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? todoImg,
    Expression<String>? tags,
    Expression<DateTime>? dueDate,
    Expression<DateTime>? createAt,
    Expression<DateTime>? updateAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (todoImg != null) 'todo_img': todoImg,
      if (tags != null) 'tags': tags,
      if (dueDate != null) 'due_date': dueDate,
      if (createAt != null) 'create_at': createAt,
      if (updateAt != null) 'update_at': updateAt,
    });
  }

  TodoCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String?>? todoImg,
    Value<List<String>?>? tags,
    Value<DateTime?>? dueDate,
    Value<DateTime>? createAt,
    Value<DateTime>? updateAt,
  }) {
    return TodoCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      todoImg: todoImg ?? this.todoImg,
      tags: tags ?? this.tags,
      dueDate: dueDate ?? this.dueDate,
      createAt: createAt ?? this.createAt,
      updateAt: updateAt ?? this.updateAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (todoImg.present) {
      map['todo_img'] = Variable<String>(todoImg.value);
    }
    if (tags.present) {
      map['tags'] = Variable<String>(
        $TodoTable.$convertertagsn.toSql(tags.value),
      );
    }
    if (dueDate.present) {
      map['due_date'] = Variable<DateTime>(dueDate.value);
    }
    if (createAt.present) {
      map['create_at'] = Variable<DateTime>(createAt.value);
    }
    if (updateAt.present) {
      map['update_at'] = Variable<DateTime>(updateAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TodoCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('todoImg: $todoImg, ')
          ..write('tags: $tags, ')
          ..write('dueDate: $dueDate, ')
          ..write('createAt: $createAt, ')
          ..write('updateAt: $updateAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TodoTable todo = $TodoTable(this);
  late final TodoDao todoDao = TodoDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [todo];
}

typedef $$TodoTableCreateCompanionBuilder =
    TodoCompanion Function({
      Value<int> id,
      required String title,
      Value<String?> todoImg,
      Value<List<String>?> tags,
      Value<DateTime?> dueDate,
      Value<DateTime> createAt,
      Value<DateTime> updateAt,
    });
typedef $$TodoTableUpdateCompanionBuilder =
    TodoCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String?> todoImg,
      Value<List<String>?> tags,
      Value<DateTime?> dueDate,
      Value<DateTime> createAt,
      Value<DateTime> updateAt,
    });

class $$TodoTableFilterComposer extends Composer<_$AppDatabase, $TodoTable> {
  $$TodoTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get todoImg => $composableBuilder(
    column: $table.todoImg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<List<String>?, List<String>, String>
  get tags => $composableBuilder(
    column: $table.tags,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createAt => $composableBuilder(
    column: $table.createAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updateAt => $composableBuilder(
    column: $table.updateAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TodoTableOrderingComposer extends Composer<_$AppDatabase, $TodoTable> {
  $$TodoTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get todoImg => $composableBuilder(
    column: $table.todoImg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tags => $composableBuilder(
    column: $table.tags,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createAt => $composableBuilder(
    column: $table.createAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updateAt => $composableBuilder(
    column: $table.updateAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TodoTableAnnotationComposer
    extends Composer<_$AppDatabase, $TodoTable> {
  $$TodoTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get todoImg =>
      $composableBuilder(column: $table.todoImg, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>?, String> get tags =>
      $composableBuilder(column: $table.tags, builder: (column) => column);

  GeneratedColumn<DateTime> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => column);

  GeneratedColumn<DateTime> get createAt =>
      $composableBuilder(column: $table.createAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updateAt =>
      $composableBuilder(column: $table.updateAt, builder: (column) => column);
}

class $$TodoTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TodoTable,
          TodoData,
          $$TodoTableFilterComposer,
          $$TodoTableOrderingComposer,
          $$TodoTableAnnotationComposer,
          $$TodoTableCreateCompanionBuilder,
          $$TodoTableUpdateCompanionBuilder,
          (TodoData, BaseReferences<_$AppDatabase, $TodoTable, TodoData>),
          TodoData,
          PrefetchHooks Function()
        > {
  $$TodoTableTableManager(_$AppDatabase db, $TodoTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TodoTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TodoTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TodoTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> todoImg = const Value.absent(),
                Value<List<String>?> tags = const Value.absent(),
                Value<DateTime?> dueDate = const Value.absent(),
                Value<DateTime> createAt = const Value.absent(),
                Value<DateTime> updateAt = const Value.absent(),
              }) => TodoCompanion(
                id: id,
                title: title,
                todoImg: todoImg,
                tags: tags,
                dueDate: dueDate,
                createAt: createAt,
                updateAt: updateAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                Value<String?> todoImg = const Value.absent(),
                Value<List<String>?> tags = const Value.absent(),
                Value<DateTime?> dueDate = const Value.absent(),
                Value<DateTime> createAt = const Value.absent(),
                Value<DateTime> updateAt = const Value.absent(),
              }) => TodoCompanion.insert(
                id: id,
                title: title,
                todoImg: todoImg,
                tags: tags,
                dueDate: dueDate,
                createAt: createAt,
                updateAt: updateAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TodoTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TodoTable,
      TodoData,
      $$TodoTableFilterComposer,
      $$TodoTableOrderingComposer,
      $$TodoTableAnnotationComposer,
      $$TodoTableCreateCompanionBuilder,
      $$TodoTableUpdateCompanionBuilder,
      (TodoData, BaseReferences<_$AppDatabase, $TodoTable, TodoData>),
      TodoData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TodoTableTableManager get todo => $$TodoTableTableManager(_db, _db.todo);
}
