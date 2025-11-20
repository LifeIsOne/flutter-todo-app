import 'package:flutter/material.dart';
import 'package:todo_app/screens/test_screen.dart';
import 'package:todo_app/screens/todo_create_screen.dart';
import 'package:todo_app/screens/todo_detail_screen.dart';
import 'package:todo_app/screens/todo_list_screen.dart';
import 'package:todo_app/screens/user_reg_screen.dart';
import 'package:todo_app/widgets/app_bottom_nav.dart';

class TestHomePage extends StatelessWidget {
  const TestHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo App')),
      bottomNavigationBar: AppBottomNav(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TodoDetailScreen(),
                  ),
                );
              },
              child: const Text("Detail 화면 이동"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TodoCreateScreen(),
                  ),
                );
              },
              child: const Text("등록 화면 이동"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TestScreen()),
                );
              },
              child: const Text("테스트 화면"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TodoListScreen(),
                  ),
                );
              },
              child: const Text("목록 화면 이동"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UserRegScreen(),
                  ),
                );
              },
              child: const Text("사용자 등록 화면 이동"),
            ),
          ],
        ),
      ),
    );
  }
}
