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
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: textController,
                        decoration: const InputDecoration(
                          hintText: '새로운 태그',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        final name = textController.text.trim();
                        if (name.isEmpty) return;
                        ref
                            .read(tagDaoProvider)
                            .insertTag(TagsCompanion.insert(name: name));
                        textController.clear();
                      },
                      child: const Text('추가'),
                    ),
                  ],
                ),
              ),
              // 태그 목록
              Expanded(
                child: ListView.builder(
                  itemCount: tags.length,
                  // prototypeItem: ListTile(title: Text()),
                  itemBuilder: (context, index) {
                    final tag = tags[index];
                    return ListTile(
                      title: Text(tag.name),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.close_outlined,
                          color: Color(0xFFFF4B6E),
                        ),
                        onPressed: () {
                          ref.read(tagDaoProvider).deleteTag(tag.id);
                        },
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
