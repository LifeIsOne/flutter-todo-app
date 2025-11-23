import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/screens/todo_list_screen.dart';

import '_core/theme.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      // TODO : 테마 세부 컬러 수정
      theme: lightMode,
      // theme: darkMode,
      home: TodoListScreen(),
    );
  }
}
