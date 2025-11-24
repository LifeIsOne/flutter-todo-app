import 'package:flutter/material.dart';

import '../screens/todo_create_screen.dart';
import '../screens/user_reg_screen.dart';

class AppBottomNav extends StatelessWidget {
  const AppBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 0,
      items: [
        BottomNavigationBarItem(icon: const Icon(Icons.list), label: 'List'),
        BottomNavigationBarItem(icon: const Icon(Icons.add), label: 'Create'),
        BottomNavigationBarItem(icon: const Icon(Icons.person), label: 'User'),
      ],
      onTap: (i) {
        if (i == 0) {
        } else if (i == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TodoCreateScreen()),
          );
        } else if (i == 2) {
          // 사용자 등록 화면
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const UserRegScreen()),
          );
        }
      },
    );
  }
}
