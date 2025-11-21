import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_app/_core/theme.dart';
import 'package:todo_app/screens/todo_list_screen.dart';

class TodoCreateScreen extends StatefulWidget {
  const TodoCreateScreen({super.key});

  @override
  State<TodoCreateScreen> createState() => _TodoCreateScreenState();
}

class _TodoCreateScreenState extends State<TodoCreateScreen> {
  final ImagePicker picker = ImagePicker();
  String title = '';
  File? imgFile;
  List<String> tagOptions = ['공부', '운동', '장보기', '중요', '개발'];
  List<String> selectedTags = [];

  // DatePicker
  DateTime? dueDate;

  Future<void> pickDueDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        dueDate = picked;
      });
    }
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

  // Function 추가하기
  void onSubmit() {
    print('추가하기: $title, $imgFile');

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => TodoListScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Todo')),
      body: Column(
        children: <Widget>[
          imgFile == null
              ? AspectRatio(
                  aspectRatio: 3 / 2,
                  child: Image.asset('assets/images/todo/files.png'),
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
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
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
            padding: const EdgeInsetsGeometry.all(16),
            child: TextField(
              onChanged: (value) => title = value,
              decoration: const InputDecoration(
                labelText: '할 일 입력하기',
                border: OutlineInputBorder(),
              ),
            ),
          ),

          // 태그
          Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '태그 선택',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
                Wrap(
                  spacing: 4,
                  children: tagOptions.map((tag) {
                    final isSelected = selectedTags.contains(tag);
                    return ChoiceChip(
                      showCheckmark: false,
                      selectedColor: lightColorScheme.tertiary,
                      label: Text(tag),
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
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  dueDate == null
                      ? '마감일 선택 안됨'
                      : '마감일: ${dueDate!.year}-${dueDate!.month}-${dueDate!.day}',
                ),
                ElevatedButton(onPressed: pickDueDate, child: Text('날짜 선택')),
              ],
            ),
          ),

          Spacer(),
          // 추가하기 버튼
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsetsGeometry.all(16),
              child: ElevatedButton.icon(
                onPressed: onSubmit,
                icon: const Icon(Icons.add_circle),
                label: const Text('등록하기'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: lightColorScheme.tertiary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 14,
                  ),
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
          ),
          SizedBox(height: 24),
        ],
      ),
    );
  }
}
