import 'package:drift/drift.dart';
import 'package:drift_sqflite/drift_sqflite.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:todo_app/_core/db/daos/todo_dao.dart';
import 'package:todo_app/_core/db/tables/tag_tables.dart';
import 'package:todo_app/_core/db/tables/todo_tables.dart';
import 'package:todo_app/_core/db/tables/todo_tag_tables.dart';

import 'daos/tag_dao.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Todo, Tags, TodoTags], daos: [TodoDao, TagDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    beforeOpen: (details) async {
      if (details.wasCreated) {
        final devId = await into(tags).insert(TagsCompanion.insert(name: '개발'));
        final workoutId = await into(
          tags,
        ).insert(TagsCompanion.insert(name: '운동'));
        final importantId = await into(
          tags,
        ).insert(TagsCompanion.insert(name: '중요'));

        final todo1Id = await into(todo).insert(
          TodoCompanion.insert(
            title: '추상화 인터페이스 공부',
            createAt: Value(DateTime.now()),
            updateAt: Value(DateTime.now()),
          ),
        );

        final todo2Id = await into(todo).insert(
          TodoCompanion.insert(
            title: '뜀 걸음 40분 이상',
            createAt: Value(DateTime.now()),
            updateAt: Value(DateTime.now()),
          ),
        );

        final todo3Id = await into(todo).insert(
          TodoCompanion.insert(
            title: '저녁거리 사기',
            createAt: Value(DateTime.now()),
            updateAt: Value(DateTime.now()),
          ),
        );

        await into(
          todoTags,
        ).insert(TodoTagsCompanion.insert(todoId: todo1Id, tagId: devId));
        await into(
          todoTags,
        ).insert(TodoTagsCompanion.insert(todoId: todo1Id, tagId: importantId));

        await into(
          todoTags,
        ).insert(TodoTagsCompanion.insert(todoId: todo2Id, tagId: workoutId));
      }
    },
  );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final path = p.join(dbFolder.path, 'db.sqlite');

    return SqfliteQueryExecutor(
      path: path,
      logStatements: true, // 디버그
    );
  });
}
