import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/providers/db_provider.dart';
import 'package:todo_app/screens/user_reg_screen.dart';

class Header extends ConsumerWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userProvider);

    return Row(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              userAsync.when(
                error: (error, stackTrace) =>
                    Scaffold(body: Center(child: Text('🤷‍♂️Ops'))),
                loading: () => const Center(child: CircularProgressIndicator()),
                data: (user) => Text(
                  '${user?.name ?? '당신'}의',
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
              const Text(
                'Todo List',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  letterSpacing: 0.27,
                ),
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UserRegScreen()),
            );
          },
          child: Container(
            width: 60,
            height: 60,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              // 30 = width/height 절반 → 동그라미
              child: userAsync.when(
                error: (error, stackTrace) =>
                    Scaffold(body: Center(child: Text('🤷‍♂️Ops'))),
                loading: () => const Center(child: CircularProgressIndicator()),
                data: (user) {
                  final img = user?.profileImg;

                  if (img == null) {
                    return Image.asset(
                      'assets/images/user/default.png',
                      fit: BoxFit.cover,
                    );
                  }
                  return img.startsWith('assets/')
                      ? Image.asset(img, fit: BoxFit.cover)
                      : Image.file(File(img), fit: BoxFit.cover);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
