import 'package:flutter/material.dart';

class TodoSearchBar extends StatelessWidget {
  const TodoSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsGeometry.all(8),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.8,

            height: 64,
            // color: Colors.redAccent,
            child: Padding(
              padding: const EdgeInsetsGeometry.all(8),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFEDEDED),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: '검색하기',
                            // border: InputBorder.none,
                            helperStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              // fontSize: 16,
                              color: Colors.grey,
                            ),
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.2,
                              color: Colors.grey,
                            ),
                          ),
                          onEditingComplete: () {},
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: Icon(Icons.search, color: Color(0xFFAAAAAA)),
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
