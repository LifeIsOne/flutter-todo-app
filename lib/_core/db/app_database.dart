import 'package:drift/drift.dart';
import 'package:drift_sqflite/drift_sqflite.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:todo_app/_core/db/tables/todo_tables.dart';
import 'package:todo_app/_core/db/daos/todo_dao.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Todo], daos: [TodoDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
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
