import 'dart:io';

import 'package:flutter/material.dart';
import 'package:todo_app/_core/db/app_database.dart';
import 'package:todo_app/_core/theme.dart';
import 'package:todo_app/screens/todo_detail_screen.dart';

class TodoList extends StatefulWidget {
  final List<Todo> todos;
  final Function(Todo todo) onTodoDeleted;

  const TodoList({super.key, required this.todos, required this.onTodoDeleted});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 20),
      itemCount: widget.todos.length,
      itemBuilder: (context, index) {
        final todo = widget.todos[index];

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            // color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: lightColorScheme.outline, width: 1),
            boxShadow: [
              const BoxShadow(
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
                : todo.todoImg!.startsWith('assets/')
                ? Image.asset(todo.todoImg!, width: 40, height: 40)
                : Image.file(File(todo.todoImg!), width: 40, height: 40),

            title: Text(todo.title),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TodoDetailScreen(todoId: todo.id),
                ),
              );
            },
            trailing: SizedBox(
              width: 25,
              child: InkWell(
                child: const Icon(Icons.delete, color: Color(0xFFFF4B6E)),
                onTap: () => widget.onTodoDeleted(todo),
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 4,
                    children: (todo.tags?.isEmpty ?? true)
                        ? [Text('태그 없음', style: TextStyle(color: Colors.grey))]
                        : todo.tags!.map((tag) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade50,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                tag,
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            );
                          }).toList(),
                  ),
                  Row(
                    children: [
                      Icon(Icons.event, size: 14, color: Colors.grey),
                      Text(
                        todo.dueDate == null
                            ? '마감일 없음'
                            : '${todo.dueDate!.year}-${todo.dueDate!.month.toString().padLeft(2, '0')}-${todo.dueDate!.day.toString().padLeft(2, '0')}',
                        style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                      ),
                    ],
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
