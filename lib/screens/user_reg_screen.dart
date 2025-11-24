import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/_core/theme.dart';

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

  Future<void> onSubmit() async {
    if (username.trim().isEmpty) {
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

    String? savedprofileImg;
    if (profileImg != null) {
      try {
        final appDir = await getApplicationDocumentsDirectory();
        final fileName = path.basename(profileImg!.path);
        final savedFile = File(path.join(appDir.path, 'profile_$fileName'));

        await profileImg!.copy(savedFile.path);
        savedprofileImg = savedFile.path;
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('이미지 저장 중 오류가 발생했습니다: $e')));
        return;
      }
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_name', username.trim());
    if (savedprofileImg != null) {
      await prefs.setString('user_profile_image_path', savedprofileImg);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('사용자 정보 등록')),

      body: Column(
        children: [
          // 사용자 아바타
          GestureDetector(
            onTap: pickProfileImg,
            child: CircleAvatar(
              radius: 80,
              backgroundColor: lightColorScheme.outline,
              backgroundImage: profileImg == null
                  ? null
                  : FileImage(profileImg!),
              child: profileImg == null
                  ? const Icon(Icons.person, size: 90)
                  : null,
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
    );
  }
}
