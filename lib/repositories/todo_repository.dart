import 'package:todo_app/models/todo.dart';

class TodoRepository {
  final List<Todo> todos = [
    Todo(id: 1, title: '추상화 인터페이스 공부', tags: ['공부', '중요']),
    Todo(id: 2, title: '뜀 걸음 40분 이상', tags: ['운동']),
    Todo(id: 3, title: '저녁거리 사기', tags: ['장보기', '중요']),
    Todo(id: 4, title: 'Drift, Hive 적용', tags: ['개발']),
    Todo(id: 5, title: '다음 단계'),
  ];

  List<Todo> getTodos() {
    return [...todos];
  }

  // void getTodo(Todo todo) {
  //   todos = [...todos, todo];
  // }

  void addTodo(Todo todo) {
    final newTodo = Todo(
      id: todos.length + 1,
      title: todo.title,
      todoImg: todo.todoImg,
      tags: todo.tags,
      createAt: DateTime.now(),
      updateAt: DateTime.now(),
    );

    todos.add(newTodo);
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
