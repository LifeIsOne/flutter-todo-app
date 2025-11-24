import 'dart:io';

import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/_core/db/app_database.dart';
import 'package:todo_app/_core/theme.dart';
import 'package:todo_app/providers/db_provider.dart';
import 'package:todo_app/providers/user_provider.dart';

class UserRegScreen extends ConsumerStatefulWidget {
  const UserRegScreen({super.key});

  @override
  ConsumerState<UserRegScreen> createState() => _UserRegScreenState();
}

class _UserRegScreenState extends ConsumerState<UserRegScreen> {
  final ImagePicker picker = ImagePicker();
  final nameController = TextEditingController();

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
    final username = nameController.text.trim();

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
    await ref
        .read(userControllerProvider)
        .updateUser(name: username, profileImg: profileImg?.path);

    ref.invalidate(userProvider);

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
              controller: nameController,
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
