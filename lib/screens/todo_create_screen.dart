import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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

  // 이미지 등록
  Future<void> pickFromGallery() async {
    final XFile? picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        imgFile = File(picked.path);
      });
    }
  }

  // 추가하기
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
        children: [
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

          // 추가하기 버튼
          ElevatedButton.icon(
            onPressed: onSubmit,
            icon: const Icon(Icons.add_circle),
            label: const Text('등록하기'),
            style: ElevatedButton.styleFrom(
              // backgroundColor: Colors.lightGreen,
              // foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
