import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:todo_app/_core/db/app_database.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/providers/db_provider.dart';
import 'package:todo_app/repositories/todo_repository.dart';

final todoSearchTermProvider = StateProvider<String>((ref) => '');

final todoSelectedTagProvider = StateProvider<String?>((ref) => null);

final filteredTodoListProvider = Provider<AsyncValue<List<TodoData>>>((ref) {
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

class TodoNotifier extends StateNotifier<List<Todo>> {
  final TodoRepository todoRepository;

  TodoNotifier(this.todoRepository) : super(todoRepository.getTodos());

  void add(Todo todo) {
    final newTodo = Todo(
      id: state.isEmpty ? 1 : (state.last.id ?? 0) + 1,
      title: todo.title,
      todoImg: todo.todoImg,
      tags: todo.tags,
      dueDate: todo.dueDate,
      createAt: todo.createAt,
      updateAt: todo.updateAt,
    );
    state = [...state, newTodo];
  }

  void createTodo(TodoData todo) {
    final newTodo = TodoData(
      id: todo.id,
      title: todo.title,
      createAt: todo.createAt,
      updateAt: todo.createAt,
    );
  }

  void remove(int id) {
    state = state.where((todo) => todo.id != id).toList();
  }

  void update(Todo updateTodo) {
    state = state.map((todo) {
      if (todo.id == updateTodo.id) {
        return updateTodo;
      }
      return todo;
    }).toList();
  }
}

final todoProvider = StateNotifierProvider<TodoNotifier, List<Todo>>((ref) {
  return TodoNotifier(TodoRepository());
});
