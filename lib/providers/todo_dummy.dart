import 'package:todo_app/models/todo.dart';

class TodoDummy {
  List<Todo> todos = [
    Todo(id: 1, title: '리스트 스크린 완성'),
    Todo(id: 2, title: '리스트 스크린 완성'),
    Todo(id: 3, title: '리스트 스크린 완성'),
    Todo(id: 4, title: '리스트 스크린 완성'),
    Todo(id: 5, title: '리스트 스크린 완성'),
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

  void deleteTodo(int id) {}

  void updateTodo(int id) {}
}
