import 'package:flutter/material.dart';
import 'package:todo_app/screens/tag_manage_screen.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Tag',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            TextButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TagManageScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.tune, size: 16),
              label: const Text('관리'),
              style: TextButton.styleFrom(
                foregroundColor: Colors.grey[600],
                textStyle: const TextStyle(fontSize: 13),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: tagOptions.map((tag) {
                final isSelected = selectedTag == tag;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: _buildTagButton(context, tag, isSelected),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTagButton(BuildContext context, String tag, bool isSelected) {
    // Theme에서 다크/라이트 자동 감지
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue : Colors.transparent,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isSelected ? Colors.blue : Colors.grey.withValues(alpha: 0.2),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: () => onTagSelected(tag),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
            child: Text(
              tag,
              style: TextStyle(
                color: isSelected
                    ? Colors.white
                    : isDark
                    ? Colors.grey[300] // ← 다크모드 텍스트
                    : Colors.blue, // ← 라이트모드 텍스트
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
