import 'dart:io';

import 'package:flutter/material.dart';
import 'package:todo_app/widgets/app_bottom_nav.dart';

class TodoCreateScreen extends StatefulWidget {
  const TodoCreateScreen({super.key});

  @override
  State<TodoCreateScreen> createState() => _TodoCreateScreenState();
}

class _TodoCreateScreenState extends State<TodoCreateScreen> {
  // final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Todo')),
      body: Column(
        children: [
          // 이미지
          AspectRatio(aspectRatio: 16 / 9, child: Image.file(File(imagePath!))),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Column(
                        children: [TextField(onChanged: (value) {})],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: AppBottomNav(),
    );
  }
}
