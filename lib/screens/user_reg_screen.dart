import 'package:flutter/material.dart';
import 'package:todo_app/widgets/app_bottom_nav.dart';

class UserRegScreen extends StatelessWidget {
  const UserRegScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('사용자 정보 등록')),
      body: Center(child: Container()),
      bottomNavigationBar: AppBottomNav(),
    );
  }
}
