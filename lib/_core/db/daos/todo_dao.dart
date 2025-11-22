import 'package:drift/drift.dart';
import 'package:todo_app/_core/db/app_database.dart';
import 'package:todo_app/_core/db/tables/todo_tables.dart';

part 'todo_dao.g.dart';

@DriftAccessor(tables: [Todo])
class TodoDao extends DatabaseAccessor<AppDatabase> with _$TodoDaoMixin {
  TodoDao(AppDatabase AppDb) : super(AppDb);

  Future<List<TodoData>> getAllTodos() {
    return select(todo).get();
  }

  Stream<List<TodoData>> watchTodos() {
    return select(todo).watch();
  }

  Future<TodoData> getTodoById(int id) {
    return (select(todo)..where((t) => t.id.equals(id))).getSingle();
  }

  Future<int> insertTodo(TodoCompanion data) {
    return into(todo).insert(data);
  }

  Future<bool> updateTodo(TodoCompanion data) {
    return update(todo).replace(data);
  }

  Future<int> deleteTodoById(int id) {
    return (delete(todo)..where((todo) => todo.id.equals(id))).go();
  }
}
