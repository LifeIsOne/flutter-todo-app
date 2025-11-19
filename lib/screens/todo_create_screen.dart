import 'package:flutter/material.dart';
import 'package:todo_app/widgets/app_bottom_nav.dart';

class TodoCreateScreen extends StatelessWidget {
  const TodoCreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Todo')),
      bottomNavigationBar: AppBottomNav(),
    );
  }
}
