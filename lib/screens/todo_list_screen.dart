import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/providers/todo_dummy.dart';
import 'package:todo_app/screens/todo_create_screen.dart';
import 'package:todo_app/widgets/header.dart';
import 'package:todo_app/widgets/todo_search_bar.dart';

import '../widgets/select_tag.dart';
import '../widgets/todo_list.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<String> tagOptions = ['공부', '운동', '장보기', '중요', '개발'];
  String? selectedTag;
  List<Todo> todos = [];
  TodoDummy todoDummy = TodoDummy();

  List<Todo> get filteredTodos {
    if (selectedTag == null) {
      return todos;
    }
    return todos.where((item) => item.tags.contains(selectedTag)).toList();
  }

  @override
  void initState() {
    super.initState();
    todos = todoDummy.getTodos();
  }

  @override
  Widget build(BuildContext context) {
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
                setState(() {
                  todoDummy.deleteTodo(todo.id ?? 0);
                  todos.remove(todo);
                });
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
