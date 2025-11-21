import 'package:flutter_riverpod/legacy.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/repositories/todo_repository.dart';

class TodoNotifier extends StateNotifier<List<Todo>> {
  final TodoRepository todoRepository;

  TodoNotifier(this.todoRepository) : super(todoRepository.getTodos());

  void add(Todo todo) {
    state = [...state, todo];
  }

  void remove(int id) {
    state = state.where((todo) => todo.id != id).toList();
  }
}

final todoProvider = StateNotifierProvider<TodoNotifier, List<Todo>>((ref) {
  return TodoNotifier(TodoRepository());
});
