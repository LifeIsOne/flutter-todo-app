import 'package:flutter/material.dart';

class TodoDetailScreen extends StatelessWidget {

  const TodoDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Todo Detail'),),
      body: Container(
        child: Text('todo detail'),
      ),
    );
  }
}
