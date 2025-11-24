import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:todo_app/_core/db/app_database.dart';
import 'package:todo_app/_core/db/daos/todo_dao.dart';
import 'package:todo_app/providers/db_provider.dart';

final todoSearchTermProvider = StateProvider<String>((ref) => '');

final todoSelectedTagProvider = StateProvider<String?>((ref) => null);

final filteredTodoListProvider = Provider<AsyncValue<List<Todo>>>((ref) {
  final todosAsync = ref.watch(todoListProvider);
  final searchTerm = ref.watch(todoSearchTermProvider);
  final selectedTag = ref.watch(todoSelectedTagProvider);

  return todosAsync.when(
    data: (todos) {
      final filtered = todos.where((todo) {
        final tagMatch =
            selectedTag == null || (todo.tags?.contains(selectedTag) ?? false);
        final searchMatch =
            searchTerm.isEmpty ||
            todo.title.toLowerCase().contains(searchTerm.toLowerCase());
        return tagMatch && searchMatch;
      }).toList();
      return AsyncValue.data(filtered);
    },
    loading: () => const AsyncValue.loading(),
    error: (error, stack) => AsyncValue.error(error, stack),
  );
});

class TodoController {
  final TodoDao todoDao;

  TodoController(this.todoDao);

  // Drift Todo 항목 추가
  Future<void> addTodo({
    required String title,
    String? todoImg,
    List<String> tags = const [],
    DateTime? dueDate,
  }) async {
    final companion = TodosCompanion.insert(
      title: title,
      todoImg: Value(todoImg),
      tags: Value(tags),
      dueDate: Value(dueDate),
    );
    await todoDao.insertTodo(companion);
  }

  Future<void> deleteTodo(int id) async {
    await todoDao.deleteTodoById(id);
  }

  Future<void> updateTodo(Todo todo) async {
    await todoDao.updateTodo(todo.toCompanion(true));
  }
}

final todoProvider = Provider<TodoController>((ref) {
  final dao = ref.watch(todoDaoProvider);
  return TodoController(dao);
});
