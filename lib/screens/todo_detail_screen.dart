import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/_core/db/app_database.dart';
import 'package:todo_app/_core/theme.dart';
import 'package:todo_app/providers/db_provider.dart';
import 'package:todo_app/screens/todo_form_screen.dart';

class TodoDetailScreen extends ConsumerWidget {
  final int todoId;

  const TodoDetailScreen({super.key, required this.todoId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoAsync = ref.watch(todoDetailProvider(todoId));

    return todoAsync.when(
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (error, stackTrace) =>
          const Scaffold(body: Center(child: Text('🤷‍♂️Ops'))),
      data: (todo) => _buildDetail(context, todo),
    );
  }

  // 전체 화면
  Widget _buildDetail(BuildContext context, Todo todo) {
    final dueText = todo.dueDate == null
        ? '마감일 없음'
        : '${todo.dueDate!.year}-'
              '${todo.dueDate!.month.toString().padLeft(2, '0')}-'
              '${todo.dueDate!.day.toString().padLeft(2, '0')} '
              '${todo.dueDate!.hour.toString().padLeft(2, '0')}:'
              '${todo.dueDate!.minute.toString().padLeft(2, '0')}';

    return Scaffold(
      appBar: AppBar(title: const Text('상세 화면')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildImage(todo),
              const SizedBox(height: 20),
              _buildTitle(todo),
              const SizedBox(height: 20),
              _buildTags(todo),
              const SizedBox(height: 16),
              _buildDueDate(dueText),
              const SizedBox(height: 20),
              _buildEditButton(context),
            ],
          ),
        ),
      ),
    );
  }

  // 이미지
  Widget _buildImage(Todo todo) {
    return AspectRatio(
      aspectRatio: 3 / 2,
      child: todo.todoImg == null
          ? Image.asset('assets/images/todo/default.png', fit: BoxFit.cover)
          : todo.todoImg!.startsWith('assets/')
          ? Image.asset(todo.todoImg!, fit: BoxFit.cover)
          : Image.file(File(todo.todoImg!), fit: BoxFit.cover),
    );
  }

  // 제목
  Widget _buildTitle(Todo todo) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Text(todo.title, style: const TextStyle(fontSize: 16)),
    );
  }

  // 태그
  Widget _buildTags(Todo todo) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '태그',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 4,
          children: (todo.tags?.isEmpty ?? true)
              ? [const Text('태그 없음', style: TextStyle(color: Colors.grey))]
              : todo.tags!
                    .map(
                      (tag) => Chip(
                        label: Text(
                          tag,
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        backgroundColor: Colors.blue.shade50,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        side: BorderSide.none,
                      ),
                    )
                    .toList(),
        ),
      ],
    );
  }

  // 마감일
  Widget _buildDueDate(String dueText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '마감일',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade400),
          ),
          child: Row(
            children: [
              const Icon(Icons.event, color: Colors.grey),
              const SizedBox(width: 8),
              Text(dueText, style: const TextStyle(fontSize: 14)),
            ],
          ),
        ),
      ],
    );
  }

  //수정 버튼
  Widget _buildEditButton(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.edit),
      label: const Text(
        '수정하기',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: lightColorScheme.tertiary,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TodoFormScreen(todoId: todoId),
          ),
        );
      },
    );
  }
}
