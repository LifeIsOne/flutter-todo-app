import 'dart:io';

import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/_core/db/app_database.dart';
import 'package:todo_app/_core/theme.dart';
import 'package:todo_app/providers/db_provider.dart';

class TodoCreateScreen extends ConsumerStatefulWidget {
  const TodoCreateScreen({super.key});

  @override
  ConsumerState<TodoCreateScreen> createState() => _TodoCreateScreenState();
}

class _TodoCreateScreenState extends ConsumerState<TodoCreateScreen> {
  final ImagePicker picker = ImagePicker();
  File? imgFile;
  final titleController = TextEditingController();

  List<String> tagOptions = ['공부', '운동', '장보기', '중요', '개발'];
  List<String> selectedTags = [];

  // Date + Time Picker
  DateTime? dueDate;
  TimeOfDay? dueTime;

  @override
  void initState() {
    super.initState();

    checkTempTodo();
  }

  Future<void> checkTempTodo() async {
    final prefs = await SharedPreferences.getInstance();
    final tempTodo = prefs.getString('temp_todo');

    if (tempTodo != null) {
      WidgetsBinding.instance.addPostFrameCallback((t) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text(
                '임시 저장된 항목이 있습니다.',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              content: Text('"$tempTodo"'),
              actions: [
                TextButton(
                  child: const Text('삭제하기'),
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.remove('temp_todo');
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('불러오기'),
                  onPressed: () {
                    titleController.text = tempTodo;
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      });
    }
  }

  // 취소하기 -> 저장(임시)
  Future<void> onCancel() async {
    final prefs = await SharedPreferences.getInstance();
    final finalTitle = titleController.text.trim();

    if (finalTitle.isNotEmpty) {
      await prefs.setString('temp_todo', titleController.text);
    }

    Navigator.of(context).pop();
  }

  Future<void> pickDueDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
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

  Future<void> onSubmit() async {
    // 프론트 단 검증
    final finalTitle = titleController.text.trim();
    if (finalTitle.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            '🤦‍♀️아무것도 입력하지 않으셨습니다!🤷‍♂️',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
        ),
      );
      return;
    }

    DateTime? sumDue;
    if (dueDate != null) {
      sumDue = DateTime(
        dueDate!.year,
        dueDate!.month,
        dueDate!.day,
        dueTime?.hour ?? 0,
        dueTime?.minute ?? 0,
      );
    }

    final newTodo = TodoCompanion(
      title: Value(titleController.text),
      todoImg: Value(imgFile?.path),
      tags: Value(selectedTags),
      dueDate: Value(sumDue),
      createAt: Value(DateTime.now()),
      updateAt: Value(DateTime.now()),
    );

    await ref.read(todoDaoProvider).insertTodo(newTodo);

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('temp_todo');

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final dueText = dueDate == null
        ? '마감일 선택'
        : '${dueDate!.year}-${dueDate!.month.toString().padLeft(2, '0')}-${dueDate!.day.toString().padLeft(2, '0')}'
              '${dueTime == null ? '' : ' ${dueTime!.hour.toString().padLeft(2, '0')}:${dueTime!.minute.toString().padLeft(2, '0')}'}';

    return Scaffold(
      appBar: AppBar(title: Text('할 일 추가하기')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              imgFile == null
                  ? AspectRatio(
                      aspectRatio: 3 / 2,
                      child: Image.asset('assets/images/todo/default.png'),
                    )
                  : AspectRatio(
                      aspectRatio: 3 / 2,
                      child: Image.file(imgFile!, fit: BoxFit.cover),
                    ),
              const SizedBox(height: 10),

              ElevatedButton.icon(
                onPressed: pickFromGallery,
                icon: const Icon(Icons.photo_library),
                label: const Text('사진 선택하기'),
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

              // 텍스트 필드
              Padding(
                padding: const EdgeInsetsGeometry.symmetric(vertical: 10),
                child: TextField(
                  controller: titleController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    hintText: '할 일 입력하기',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),

              // 태그
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
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
              ),

              // 마감일 선택
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '마감일 선택',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
              const SizedBox(height: 10),
              // 등록버튼
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: onCancel,
                      icon: const Icon(Icons.backspace),
                      label: const Text('취소하기'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: lightColorScheme.error,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 4),

                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: onSubmit,
                      icon: const Icon(Icons.add_circle),
                      label: const Text('등록하기'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: lightColorScheme.tertiary,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
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
            ],
          ),
        ),
      ),
    );
  }
}
