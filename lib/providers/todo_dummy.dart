import 'package:todo_app/models/todo.dart';

class TodoDummy {
  List<Todo> todos = [
    Todo(id: 1, title: '리스트 화면'),
    Todo(id: 2, title: '디테일 페이지'),
    Todo(id: 3, title: '수정/삭제'),
    Todo(id: 4, title: 'Drift, Hive 적용'),
    Todo(id: 5, title: '다음 단계'),
  ];

  List<Todo> getTodos() {
    return todos;
  }

  Todo getTodo(int id) {
    return todos[id];
  }

  Todo addTodo(Todo todo) {
    Todo newTodo = Todo(id: todos.length + 1, title: todo.title);
    todos.add(newTodo);
    return newTodo;
  }

  void deleteTodo(int id) {
    todos.removeWhere((todo) => todo.id == id);
  }

  void updateTodo(int id, String newTitle) {
    for (int i = 0; i < todos.length; i++) {
      if (todos[i].id == id) {
        todos[i] = Todo(id: id, title: newTitle);
        break;
      }
    }
  }
}
