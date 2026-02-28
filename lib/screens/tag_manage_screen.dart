import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/_core/db/app_database.dart';
import 'package:todo_app/providers/tag_provider.dart';

class TagManageScreen extends ConsumerWidget {
  const TagManageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tagAsync = ref.watch(tagListProvider);
    final textController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('태그 관리')),
      body: tagAsync.when(
        error: (error, stackTrace) =>
            Scaffold(body: Center(child: Text('🤷‍♂️Ops'))),
        loading: () => const Center(child: CircularProgressIndicator()),
        data: (tags) {
          return Column(
            children: [
              // 태그 추가
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: textController,
                        decoration: InputDecoration(
                          hintText: '새로운 태그',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          final name = textController.text.trim();
                          if (name.isEmpty) return;
                          ref
                              .read(tagDaoProvider)
                              .insertTag(TagsCompanion.insert(name: name));
                          textController.clear();
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('추가'),
                      ),
                    ),
                  ],
                ),
              ),
              // 태그 목록
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: tags.length,
                  itemBuilder: (context, index) {
                    final tag = tags[index];
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      child: ListTile(
                        leading: const Icon(
                          Icons.label,
                          color: Color(0xFF2E81F6),
                        ),
                        title: Text(tag.name),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.close,
                            size: 30,
                            color: Color(0xFFFF4B6E),
                          ),
                          onPressed: () {
                            ref.read(tagDaoProvider).deleteTag(tag.id);
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
