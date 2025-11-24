import 'package:drift/drift.dart';
import 'package:todo_app/_core/db/app_database.dart';
import 'package:todo_app/_core/db/tables/todo_tables.dart';

part 'todo_dao.g.dart';

@DriftAccessor(tables: [Todos])
class TodoDao extends DatabaseAccessor<AppDatabase> with _$TodoDaoMixin {
  TodoDao(AppDatabase appDb) : super(appDb);

  Future<List<Todo>> getAllTodos() {
    return (select(todos)..orderBy([
          (todo) =>
              OrderingTerm(expression: todo.dueDate, mode: OrderingMode.asc),
        ]))
        .get();
  }

  Stream<List<Todo>> watchTodos() {
    return (select(todos)..orderBy([
          (todo) =>
              OrderingTerm(expression: todo.dueDate, mode: OrderingMode.asc),
        ]))
        .watch();
  }

  Stream<Todo> watchTodoById(int id) {
    return (select(todos)..where((t) => t.id.equals(id))).watchSingle();
  }

  Future<Todo> getTodoById(int id) async {
    return (select(todos)..where((todo) => todo.id.equals(id))).getSingle();
  }

  Future<int> insertTodo(TodosCompanion data) {
    return into(todos).insert(data);
  }

  Future<bool> updateTodo(TodosCompanion data) {
    return update(todos).replace(data);
  }

  Future<int> deleteTodoById(int id) {
    return (delete(todos)..where((todo) => todo.id.equals(id))).go();
  }
}
