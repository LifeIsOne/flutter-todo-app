import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
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

  @override
  void initState() {
    super.initState();
    // ← 추가! 화면 열릴 때 기존 유저 정보 불러오기
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final user = await ref.read(userProvider.future);
      if (user != null) {
        nameController.text = user.name;
        if (user.profileImg != null &&
            !user.profileImg!.startsWith('assets/')) {
          setState(() {
            profileImg = File(user.profileImg!);
          });
        }
      }
    });
  }

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

    if (username.isEmpty) {
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

    try {
      await ref
          .read(userControllerProvider)
          .updateUser(
            name: username,
            profileImg: profileImg?.path ?? 'assets/images/user/avatar00.png',
          );
      ref.invalidate(userProvider);
      if (mounted) Navigator.pop(context);
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('업데이트에 실패했습니다!')));
      }
    }
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
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40), // ← 둥글기만 조절
              child: profileImg == null
                  ? Container(
                      width: 160, // ← 크기 고정
                      height: 160,
                      color: lightColorScheme.outline,
                      child: const Icon(Icons.person, size: 90),
                    )
                  : Image.file(
                      profileImg!,
                      width: 160, // ← 크기 고정
                      height: 160,
                      fit: BoxFit.cover,
                    ),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.edit),
                    const SizedBox(width: 10),
                    const Text(
                      "등록하기",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
