import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/providers/todo_provider.dart';
import 'package:todo_app/screens/todo_create_screen.dart';
import 'package:todo_app/widgets/header.dart';
import 'package:todo_app/widgets/todo_search_bar.dart';

import '../widgets/select_tag.dart';
import '../widgets/todo_list.dart';

class TodoListScreen extends ConsumerStatefulWidget {
  const TodoListScreen({super.key});

  @override
  ConsumerState<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends ConsumerState<TodoListScreen> {
  List<String> tagOptions = ['공부', '운동', '장보기', '중요', '개발'];
  String? selectedTag;

  @override
  Widget build(BuildContext context) {
    final todos = ref.watch(todoProvider);

    final filteredTodos = selectedTag == null
        ? todos
        : todos.where((todo) => todo.tags.contains(selectedTag)).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: Column(
        children: [
          const SizedBox(height: 80),
          const Header(), // title, 사용자 이름, 프로필 이미지
          // 검색 바
          const TodoSearchBar(),
          // 태그
          SelectTag(
            tagOptions: tagOptions,
            selectedTag: selectedTag,
            onTagSelected: (tag) {
              setState(() {
                if (selectedTag == tag) {
                  selectedTag = null;
                } else {
                  selectedTag = tag;
                }
              });
            },
          ),
          //  리스트 빌드
          Expanded(
            child: TodoList(
              todos: filteredTodos,
              onTodoDeleted: (todo) {
                _showDeleteDialog(todo);
              },
            ),
          ),
        ],
      ),
      // 추가하기 버튼
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TodoCreateScreen()),
          );
        },
        child: const Text('+'),
      ),
    );
  }

  void _showDeleteDialog(Todo todo) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Todo'),
          content: const Text('삭제하시겠습니까?'),
          actions: [
            TextButton(
              onPressed: () {
                ref.read(todoProvider.notifier).remove(todo.id!);
                Navigator.of(context).pop();
              },
              child: const Text('삭제하기'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('취소하기'),
            ),
          ],
        );
      },
    );
  }
}
