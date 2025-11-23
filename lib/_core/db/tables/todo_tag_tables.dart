import 'package:drift/drift.dart';
import 'package:todo_app/_core/db/tables/tag_tables.dart';
import 'package:todo_app/_core/db/tables/todo_tables.dart';

class TodoTags extends Table {
  IntColumn get todoId => integer().references(Todo, #id)();

  IntColumn get tagId => integer().references(Tags, #id)();

  @override
  Set<Column> get primaryKey => {todoId, tagId};
}
