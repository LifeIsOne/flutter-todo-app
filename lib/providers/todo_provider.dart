import 'package:flutter_riverpod/legacy.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/repositories/todo_repository.dart';

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

  void remove(int id) {
    state = state.where((todo) => todo.id != id).toList();
  }
}

final todoProvider = StateNotifierProvider<TodoNotifier, List<Todo>>((ref) {
  return TodoNotifier(TodoRepository());
});
