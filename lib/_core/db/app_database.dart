import 'package:drift/drift.dart';
import 'package:drift_sqflite/drift_sqflite.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:todo_app/_core/db/daos/todo_dao.dart';
import 'package:todo_app/_core/db/tables/todo_tables.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Todo], daos: [TodoDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    beforeOpen: (details) async {
      if (details.wasCreated) {
        // 데이터베이스가 생성될 때 더미 데이터 삽입
        await into(todo).insert(
          TodoCompanion.insert(
            title: '추상화 인터페이스 공부',
            tags: Value(['공부', '중요']),
            createAt: Value(DateTime.now()),
            updateAt: Value(DateTime.now()),
          ),
        );

        await into(todo).insert(
          TodoCompanion.insert(
            title: '뜀 걸음 40분 이상',
            tags: Value(['운동']),
            createAt: Value(DateTime.now()),
            updateAt: Value(DateTime.now()),
          ),
        );

        await into(todo).insert(
          TodoCompanion.insert(
            title: '저녁거리 사기',
            tags: Value(['장보기,중요']),
            createAt: Value(DateTime.now()),
            updateAt: Value(DateTime.now()),
          ),
        );

        await into(todo).insert(
          TodoCompanion.insert(
            title: 'Drift, Hive 적용',
            tags: Value(['개발']),
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
