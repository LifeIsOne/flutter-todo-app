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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: todo.todoImg != null
                  ? Image.file(File(todo.todoImg!))
                  : Image.asset('assets/images/todo/default.png'),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
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

                SizedBox(height: 10),

                // 태그
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '태그',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: Wrap(
                          spacing: 4,
                          children: (todo.tags == null || todo.tags.isEmpty)
                              ? [
                                  Text(
                                    '태그 없음',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ]
                              : todo.tags.map((tag) {
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
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                // 마감일
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '마감일',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),

                    Row(
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
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
