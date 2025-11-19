import 'package:flutter/material.dart';
import 'package:todo_app/screens/todo_create_screen.dart';
import 'package:todo_app/screens/user_reg_screen.dart';
import 'package:todo_app/screens/todo_detail_screen.dart';

class TodoListScreen extends StatelessWidget {
  const TodoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo App')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TodoDetailScreen()),
                );
              },
              child: const Text("Detail 화면 이동"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TodoCreateScreen()),
                );
              },
              child: const Text("등록 화면 이동"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UserRegScreen()),
                );
              },
              child: const Text("사용자 등록 화면 이동"),
            )
          ],
        ),
      ),
    );
  }
}
