import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodoSearchBar extends ConsumerStatefulWidget {
  final Function(String) onChanged;

  const TodoSearchBar({super.key, required this.onChanged});

  @override
  ConsumerState<TodoSearchBar> createState() => _TodoSearchBarState();
}

class _TodoSearchBarState extends ConsumerState<TodoSearchBar> {
  final textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.start,
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            // width: MediaQuery.of(context).size.width * 0.8, // Removed, Expanded handles this
            height: 64,
            // color: Colors.redAccent,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFEDEDED),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: TextField(
                          controller: textEditingController,
                          decoration: const InputDecoration(
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
                          onChanged: widget.onChanged,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 60,
                      height: 60,
                      child: Icon(Icons.search, color: Color(0xFFAAAAAA)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
