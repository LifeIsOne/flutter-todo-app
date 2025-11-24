import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/_core/db/app_database.dart';
import 'package:todo_app/providers/db_provider.dart';
import 'package:todo_app/providers/tag_provider.dart';
import 'package:todo_app/providers/todo_provider.dart';
import 'package:todo_app/screens/todo_create_screen.dart';
import 'package:todo_app/widgets/header.dart';
import 'package:todo_app/widgets/todo_search_bar.dart';

import '../widgets/select_tag.dart';
import '../widgets/todo_list.dart';

class TodoListScreen extends ConsumerWidget {
  const TodoListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredTodosAsync = ref.watch(filteredTodoListProvider);
    final tagAsync = ref.watch(tagListProvider);
    final tagOptions = tagAsync.value?.map((tag) => tag.name).toList() ?? [];
    final selectedTag = ref.watch(todoSelectedTagProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 80),
            const Header(), // title, 사용자 이름, 프로필 이미지
            // 검색 바
            TodoSearchBar(
              onChanged: (query) {
                ref.read(todoSearchTermProvider.notifier).state = query;
              },
            ),
            // 태그
            SelectTag(
              tagOptions: tagOptions,
              selectedTag: selectedTag,
              onTagSelected: (tag) {
                ref.read(todoSelectedTagProvider.notifier).update((state) {
                  return state == tag ? null : tag;
                });
              },
            ),
            // 리스트 빌드 + 필터
            Expanded(
              child: filteredTodosAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) =>
                    const Center(child: Text('Error loading todos')),
                data: (todos) => TodoList(
                  todos: todos,
                  onTodoDeleted: (todo) {
                    _showDeleteDialog(context, ref, todo);
                  },
                ),
              ),
            ),
          ],
        ),
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

  void _showDeleteDialog(BuildContext context, WidgetRef ref, TodoData todo) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Todo'),
          content: const Text('삭제하시겠습니까?'),
          actions: [
            TextButton(
              onPressed: () async {
                await ref.read(todoDaoProvider).deleteTodoById(todo.id);
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
