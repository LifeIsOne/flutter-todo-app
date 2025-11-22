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
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Color(0x22000000), width: 1),
            boxShadow: [
              BoxShadow(
                color: Color(0x11000000),
                offset: Offset(0, 5),
                spreadRadius: 1,
                blurRadius: 5,
              ),
            ],
          ),

          child: ListTile(
            leading: todo.todoImg == null
                ? Image.asset(
                    'assets/images/todo/default.png',
                    width: 40,
                    height: 40,
                  )
                : Image.file(File(todo.todoImg!), width: 40, height: 40),

            title: Text(todo.title),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TodoDetailScreen(todoId: todo.id!),
                ),
              );
            },
            trailing: SizedBox(
              width: 25,
              child: Row(
                children: [
                  // InkWell(child: const Icon(Icons.edit), onTap: () {}),
                  InkWell(
                    child: const Icon(Icons.delete),
                    onTap: () => onTodoDeleted(todo),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
