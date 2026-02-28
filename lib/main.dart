import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/providers/state_provider.dart';
import 'package:todo_app/screens/todo_list_screen.dart';

import '_core/theme.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      theme: lightMode,
      darkTheme: darkMode,
      themeMode: themeMode,
      home: TodoListScreen(),
    );
  }
}
