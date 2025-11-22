import 'package:flutter/material.dart';

class SelectTag extends StatelessWidget {
  final List<String> tagOptions;
  final String? selectedTag;
  final Function(String) onTagSelected;

  const SelectTag({
    super.key,
    required this.tagOptions,
    required this.selectedTag,
    required this.onTagSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Tag',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: tagOptions.map((tag) {
                    final isSelected = selectedTag == tag;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: _buildTagButton(tag, isSelected),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTagButton(String tag, bool isSelected) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue : Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.blue),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: () {
            onTagSelected(tag); // setState 대신 콜백 함수 호출
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
            child: Center(
              child: Text(
                tag,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
