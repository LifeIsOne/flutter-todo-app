import 'dart:io';

import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_app/_core/db/app_database.dart';
import 'package:todo_app/_core/theme.dart';
import 'package:todo_app/providers/db_provider.dart';

class TodoEditScreen extends ConsumerStatefulWidget {
  final int todoId;

  const TodoEditScreen({super.key, required this.todoId});

  @override
  ConsumerState<TodoEditScreen> createState() => _TodoEditScreenState();
}

class _TodoEditScreenState extends ConsumerState<TodoEditScreen> {
  final ImagePicker picker = ImagePicker();
  final titleController = TextEditingController();

  List<String> tagOptions = ['공부', '운동', '장보기', '중요', '개발'];

  File? imgFile;
  List<String> selectedTags = [];
  DateTime? dueDate;
  TimeOfDay? dueTime;

  bool isInitialized = false;

  Future<void> pickDueDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: dueDate ?? DateTime.now(),
      firstDate: DateTime(2025),
      lastDate: DateTime(2035),
    );

    if (picked != null) {
      setState(() {
        dueDate = picked;
      });
    }
  }

  Future<void> pickDueTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: dueTime ?? TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        if (dueDate == null) {
          dueDate = DateTime.now();
          dueTime = picked;
        }
        dueTime = picked;
      });
    }
  }

  void deleteDueDate() {
    setState(() {
      dueDate = null;
      dueTime = null;
    });
  }

  // Function 이미지 등록
  Future<void> pickFromGallery() async {
    final XFile? picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        imgFile = File(picked.path);
      });
    }
  }

  void onSubmit() {
    // 날짜 + 시간
    DateTime? finalDueDate;
    if (dueDate != null) {
      finalDueDate = DateTime(
        dueDate!.year,
        dueDate!.month,
        dueDate!.day,
        dueTime?.hour ?? 0,
        dueTime?.minute ?? 0,
      );
    }

    final updateTodo = TodoCompanion(
      id: Value(widget.todoId),
      title: Value(titleController.text),
      todoImg: Value(imgFile?.path),
      tags: Value(selectedTags),
      dueDate: Value(finalDueDate),
      updateAt: Value(DateTime.now()),
    );

    ref.read(todoDaoProvider).updateTodo(updateTodo);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final todosAsync = ref.watch(todoDetailProvider(widget.todoId));

    return Scaffold(
      appBar: AppBar(title: Text('수정하기')),
      body: todosAsync.when(
        loading: () =>
            Scaffold(body: Center(child: CircularProgressIndicator())),
        error: (error, stackTrace) =>
            Scaffold(body: Center(child: Text('Ops'))),

        data: (todos) {
          if (!isInitialized) {
            titleController.text = todos.title;
            selectedTags = List.from(todos.tags ?? []);
            dueDate = todos.dueDate;
            imgFile = todos.todoImg != null ? File(todos.todoImg!) : null;
            isInitialized = true;
          }

          final dueText = dueDate == null
              ? '마감일 선택'
              : '${dueDate!.year}-${dueDate!.month.toString().padLeft(2, '0')}-${dueDate!.day.toString().padLeft(2, '0')}'
                    '${dueTime == null ? '' : ' ${dueTime!.hour.toString().padLeft(2, '0')}:${dueTime!.minute.toString().padLeft(2, '0')}'}';

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AspectRatio(
                    aspectRatio: 3 / 2,
                    child: imgFile == null
                        ? Image.asset('assets/images/todo/default.png')
                        : Image.file(imgFile!),
                  ),

                  const SizedBox(height: 20),

                  ElevatedButton.icon(
                    onPressed: pickFromGallery,
                    icon: const Icon(Icons.photo_library),
                    label: const Text('사진 변경하기'),

                    style: ElevatedButton.styleFrom(
                      // backgroundColor: lightColorScheme.onError,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // 텍스트 필드
                  TextField(
                    maxLines: 3,
                    controller: titleController,
                    decoration: InputDecoration(
                      hintText: '할 일 입력하기',
                      border: OutlineInputBorder(),
                    ),
                  ),

                  SizedBox(height: 20),

                  // 태그
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '태그 선택',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Wrap(
                          spacing: 4,
                          children: tagOptions.map((tag) {
                            final isSelected = selectedTags.contains(tag);

                            return ChoiceChip(
                              showCheckmark: false,
                              selectedColor: Colors.blue,
                              label: Text(
                                tag,
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              selected: isSelected,
                              onSelected: (selected) {
                                setState(() {
                                  if (selected) {
                                    selectedTags.add(tag);
                                  } else {
                                    selectedTags.remove(tag);
                                  }
                                });
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),

                  // 마감일 선택
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '마감일 선택',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),

                      // 날짜/시간 한 블록으로 눌러서 선택
                      InkWell(
                        onTap: pickDueDate,
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.grey.shade400,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.event, color: Colors.grey),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  dueText,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                              TextButton(
                                onPressed: pickDueTime,
                                child: const Text('시간 설정'),
                              ),
                              IconButton(
                                icon: const Icon(Icons.clear, size: 18),
                                color: lightColorScheme.error,
                                onPressed: deleteDueDate,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  // 등록버튼
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: onSubmit,
                      icon: const Icon(Icons.edit),
                      label: const Text(
                        '수정하기',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: lightColorScheme.tertiary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
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
