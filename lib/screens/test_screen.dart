import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/providers/todo_dummy.dart';
import 'package:todo_app/screens/todo_create_screen.dart';

import '../widgets/todo_list.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TestScreen> {
  List<Todo> todos = [];
  TodoDummy todoDummy = TodoDummy();

  @override
  void initState() {
    super.initState();
    todos = todoDummy.getTodos();
  }

  void _showDeleteDialog(Todo todo) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Todo'),
          content: const Text('삭제하시겠습니까?'),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  todoDummy.deleteTodo(todo.id ?? 0);
                  // UI 즉각적인 업데이트를 위해 로컬 리스트에서도 삭제
                  todos.remove(todo);
                });
                Navigator.of(context).pop();
              },
              child: const Text('삭제하기'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('취소하기'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 18, right: 18),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center, // ★ 같은 라인에 맞추는 핵심
            children: <Widget>[
              const Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Todo Lists',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      '사용자',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 60,
                height: 60,
                child: Image.asset('assets/design_course/userImage.png'),
              ),
            ],
          ),
        ),
      ),
      body: TodoList(
        todos: todos,
        onTodoDeleted: (todo) {
          _showDeleteDialog(todo);
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TodoCreateScreen()),
          );
        },
        child: const Text('+'),
      ),
    );
  }
}
