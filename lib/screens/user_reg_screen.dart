import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_app/_core/theme.dart';
import 'package:todo_app/widgets/app_bottom_nav.dart';

class UserRegScreen extends StatefulWidget {
  const UserRegScreen({super.key});

  @override
  State<UserRegScreen> createState() => _UserRegScreenState();
}

class _UserRegScreenState extends State<UserRegScreen> {
  final ImagePicker picker = ImagePicker();

  File? profileImg;
  String username = '';

  Future<void> pickProfileImg() async {
    final XFile? picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        profileImg = File(picked.path);
      });
    }
  }

  void onSubmit() {
    print("사용자 등록: $username / $profileImg");

    Navigator.pop((context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('사용자 정보 등록')),

      body: Column(
        children: [
          // 사용자 이미지 영역
          GestureDetector(
            onTap: pickProfileImg,
            child: CircleAvatar(
              radius: 80,
              backgroundColor: lightColorScheme.outline,
              backgroundImage: profileImg == null
                  ? null
                  : FileImage(profileImg!),
              child: profileImg == null ? Icon(Icons.person, size: 90) : null,
            ),
          ),

          // 사용자 이름 입력
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: const InputDecoration(
                labelText: "이름 입력",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => username = value,
            ),
          ),

          // 등록 버튼
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onSubmit,
                child: const Text(
                  "등록하기",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: AppBottomNav(),
    );
  }
}
