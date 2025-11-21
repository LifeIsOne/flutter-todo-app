import 'dart:io';

import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/screens/todo_detail_screen.dart';

class TodoList extends StatelessWidget {
  final List<Todo> todos;
  final Function(Todo) onTodoDeleted;

  const TodoList({super.key, required this.todos, required this.onTodoDeleted});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          final todo = todos[index];
          return ListTile(
            leading: todo.todoImg == null
                ? Image.asset(
                    'assets/images/todo/files.png',
                    width: 40,
                    height: 40,
                  )
                : Image.file(File(todo.todoImg!), width: 40, height: 40),

            title: Text(todo.title),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TodoDetailScreen(),
                ),
              );
            },
            trailing: SizedBox(
              width: 50,
              child: Row(
                children: [
                  InkWell(
                    child: const Icon(Icons.edit),
                    onTap: () {
                      // TODO: Implement edit functionality
                    },
                  ),
                  InkWell(
                    child: const Icon(Icons.delete),
                    onTap: () => onTodoDeleted(todo),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
