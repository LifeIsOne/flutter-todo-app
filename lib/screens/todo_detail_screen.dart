import 'package:flutter/material.dart';

class TodoDetailScreen extends StatelessWidget {
  const TodoDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Todo Detail')),
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.asset(
              'assets/images/todo/interface-and-abstract-class.png',
            ),
          ),
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
                      child: Text(
                        '인터페이스와 추상화 차이',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
