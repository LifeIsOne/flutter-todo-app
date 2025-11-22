import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/providers/todo_provider.dart';

class TodoDetailScreen extends ConsumerStatefulWidget {
  final int todoId;

  const TodoDetailScreen({super.key, required this.todoId});

  @override
  ConsumerState<TodoDetailScreen> createState() => _TodoDetailScreenState();
}

class _TodoDetailScreenState extends ConsumerState<TodoDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final todos = ref.watch(todoProvider);
    final todo = todos.firstWhere((todo) => todo.id == widget.todoId);

    return Scaffold(
      appBar: AppBar(title: Text('Todo Detail')),
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: todo.todoImg != null
                ? Image.file(File(todo.todoImg!))
                : Image.asset('assets/images/todo/default.png'),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          todo.title,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // 태그
                Wrap(
                  spacing: 6,
                  children: todo.tags.map((tag) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
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
                        ),
                      ),
                    );
                  }).toList(),
                ),

                // 마감일
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      Icon(Icons.event, color: Colors.grey),
                      SizedBox(width: 8),
                      Text(
                        todo.dueDate == null
                            ? '마감일 없음'
                            : '${todo.dueDate!.year}-${todo.dueDate!.month}-${todo.dueDate!.day}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
