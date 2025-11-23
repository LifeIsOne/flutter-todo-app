import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/_core/db/app_database.dart';
import 'package:todo_app/providers/db_provider.dart';
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
  String searchTerm = ''; // 빈 문자열로 초기화하여 null-safety 확보

  @override
  Widget build(BuildContext context) {
    final todosAsync = ref.watch(todoListProvider);

    return todosAsync.when(
      loading: () => Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (error, stackTrace) => Scaffold(body: Center(child: Text('Ops'))),
      data: (todos) {
        final filteredTodos = todos.where((todo) {
          final tagMatch =
              selectedTag == null ||
              (todo.tags?.contains(selectedTag) ?? false);
          // searchTerm이 비어있으면 모든 항목을 포함하고, 그렇지 않으면 제목에 검색어가 포함된 항목만 필터링
          final searchMatch =
              searchTerm.isEmpty ||
              todo.title.toLowerCase().contains(searchTerm.toLowerCase());
          return tagMatch && searchMatch;
        }).toList();

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
                  // const 키워드 제거
                  onChanged: (query) {
                    // searchTerm 대신 onChanged 사용
                    setState(() {
                      searchTerm = query; // 오타 수정
                    });
                  },
                ),
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
          ),
          // 추가하기 버튼
          floatingActionButton: FloatingActionButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TodoCreateScreen(),
                ),
              );
            },
            child: const Text('+'),
          ),
        );
      },
    );
  }

  void _showDeleteDialog(TodoData todo) {
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
