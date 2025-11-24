import 'package:drift/drift.dart';
import 'package:drift_sqflite/drift_sqflite.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:todo_app/_core/db/daos/todo_dao.dart';
import 'package:todo_app/_core/db/daos/user_dao.dart';
import 'package:todo_app/_core/db/tables/tag_tables.dart';
import 'package:todo_app/_core/db/tables/todo_tables.dart';
import 'package:todo_app/_core/db/tables/todo_tag_tables.dart';
import 'package:todo_app/_core/db/tables/user_tables.dart';

import 'daos/tag_dao.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [Todos, Tags, TodoTags, Users],
  daos: [TodoDao, TagDao, UserDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    beforeOpen: (details) async {
      if (details.wasCreated) {
        final user = await into(users).insert(
          UsersCompanion.insert(
            name: '공부',
            profileImg: Value('assets/images/user/avatar01.png'),
          ),
        );

        final tag1Id = await into(
          tags,
        ).insert(TagsCompanion.insert(name: '공부'));
        final tag2Id = await into(
          tags,
        ).insert(TagsCompanion.insert(name: '운동'));
        final tag3Id = await into(
          tags,
        ).insert(TagsCompanion.insert(name: '중요'));
        final tag4Id = await into(
          tags,
        ).insert(TagsCompanion.insert(name: '일과'));
        final tag5Id = await into(
          tags,
        ).insert(TagsCompanion.insert(name: '목표'));

        final todo1Id = await into(todos).insert(
          TodosCompanion.insert(
            title: '추상화 인터페이스 비교하기',
            tags: Value(['공부']),
            dueDate: Value(DateTime.now()),
            createAt: Value(DateTime.now()),
            updateAt: Value(DateTime.now()),
          ),
        );

        final todo2Id = await into(todos).insert(
          TodosCompanion.insert(
            title: '뜀 걸음 40분 이상',
            tags: Value(['운동', '일과']),
            dueDate: Value(DateTime.now()),
            createAt: Value(DateTime.now()),
            updateAt: Value(DateTime.now()),
          ),
        );

        final todo3Id = await into(todos).insert(
          TodosCompanion.insert(
            title: '저녁거리 사기',
            tags: Value(['일과']),
            dueDate: Value(DateTime.now()),
            createAt: Value(DateTime.now()),
            updateAt: Value(DateTime.now()),
          ),
        );

        final todo4Id = await into(todos).insert(
          TodosCompanion.insert(
            title: '이비인후과 방문',
            tags: Value(['중요', '일과']),
            dueDate: Value(DateTime.now()),
            createAt: Value(DateTime.now()),
            updateAt: Value(DateTime.now()),
          ),
        );
        final todo5Id = await into(todos).insert(
          TodosCompanion.insert(
            title: '파일,디렉토리는 스네이크',
            todoImg: Value('assets/images/todo/snake_case.png'),
            tags: Value(['중요']),
            dueDate: Value(DateTime(2025, 12, 31)),
            createAt: Value(DateTime.now()),
            updateAt: Value(DateTime.now()),
          ),
        );
        final todo6Id = await into(todos).insert(
          TodosCompanion.insert(
            title: '함수, 변수는 카멜',
            todoImg: Value('assets/images/todo/camel_case.png'),
            tags: Value(['중요']),
            dueDate: Value(DateTime(2025, 12, 31)),
            createAt: Value(DateTime.now()),
            updateAt: Value(DateTime.now()),
          ),
        );
        final todo7Id = await into(todos).insert(
          TodosCompanion.insert(
            title: '클래스는 파스칼',
            todoImg: Value('assets/images/todo/pascal.png'),
            tags: Value(['중요']),
            dueDate: Value(DateTime(2025, 12, 31)),
            createAt: Value(DateTime.now()),
            updateAt: Value(DateTime.now()),
          ),
        );
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
