import 'dart:io';

import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/_core/db/app_database.dart';
import 'package:todo_app/_core/theme.dart';
import 'package:todo_app/models/todo_form_state.dart';
import 'package:todo_app/providers/db_provider.dart';
import 'package:todo_app/providers/tag_provider.dart';
import 'package:todo_app/providers/todo_form_provider.dart';

class TodoFormScreen extends ConsumerStatefulWidget {
  final int? todoId;

  const TodoFormScreen({super.key, this.todoId});

  @override
  ConsumerState<TodoFormScreen> createState() => _TodoFormScreenState();
}

class _TodoFormScreenState extends ConsumerState<TodoFormScreen> {
  final titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.todoId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        final todo = await ref.read(todoDetailProvider(widget.todoId!).future);
        titleController.text = todo.title;

        ref
            .read(todoFormProvider.notifier)
            .initWithTodo(
              imgFile: todo.todoImg,
              selectedTags: todo.tags ?? [],
              dueDate: todo.dueDate,
            );
      });
    }
  }

  void onSubmit() {
    if (titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            '🤦‍♀️아무것도 입력하지 않으셨습니다!🤷‍♂️',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
        ),
      );
      return;
    }

    final formState = ref.read(todoFormProvider);
    final isNewTodo = widget.todoId == null;

    // 날짜 + 시간
    DateTime? finalDueDate;
    if (formState.dueDate != null) {
      finalDueDate = DateTime(
        formState.dueDate!.year,
        formState.dueDate!.month,
        formState.dueDate!.day,
        formState.dueTime?.hour ?? 0,
        formState.dueTime?.minute ?? 0,
      );
    }

    if (isNewTodo) {
      final newTodo = TodosCompanion.insert(
        title: titleController.text,
        todoImg: Value(formState.imgFile),
        tags: Value(formState.selectedTags),
        dueDate: Value(finalDueDate),
        updateAt: Value(DateTime.now()),
      );
      ref.read(todoDaoProvider).insertTodo(newTodo);
    } else {
      final updateTodo = TodosCompanion(
        id: Value(widget.todoId!),
        title: Value(titleController.text),
        todoImg: Value(formState.imgFile),
        tags: Value(formState.selectedTags),
        dueDate: Value(finalDueDate),
        updateAt: Value(DateTime.now()),
      );
      ref.read(todoDaoProvider).updateTodo(updateTodo);
    }

    if (!context.mounted) return;
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final formState = ref.watch(todoFormProvider);
    final isNewTodo = widget.todoId == null;
    final tagAsync = ref.watch(tagListProvider);

    if (isNewTodo) {
      return Scaffold(
        appBar: AppBar(title: Text('추가하기')),
        body: _buildForm(formState, tagAsync),
      );
    } else {
      final todosAsync = ref.watch(todoDetailProvider(widget.todoId!));

      return Scaffold(
        appBar: AppBar(title: Text('수정하기')),
        body: todosAsync.when(
          error: (error, stackTrace) =>
              Scaffold(body: Center(child: Text('Ops'))),
          loading: () =>
              Scaffold(body: Center(child: CircularProgressIndicator())),
          data: (todos) {
            return _buildForm(formState, tagAsync);
          },
        ),
      );
    }
  }

  Widget _buildForm(TodoFormState formState, AsyncValue<List<Tag>> tagAsync) {
    final tagOptions = tagAsync.value?.map((tag) => tag.name).toList() ?? [];
    final dueText = formState.dueDate == null
        ? '마감일 선택'
        : '${formState.dueDate!.year}-${formState.dueDate!.month.toString().padLeft(2, '0')}-${formState.dueDate!.day.toString().padLeft(2, '0')}'
              '${formState.dueTime == null ? '' : ' ${formState.dueTime!.hour.toString().padLeft(2, '0')}:${formState.dueTime!.minute.toString().padLeft(2, '0')}'}';

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildImagePicker(formState),
            const SizedBox(height: 20),
            // 텍스트 필드
            TextField(
              maxLines: 3,
              controller: titleController,
              decoration: InputDecoration(
                hintText: '할 일 입력하기',
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 20),

            // 태그 선택
            _buildTagSelector(tagOptions, formState),

            // 마감일 선택
            _buildDueDatePicker(formState, dueText),
            SizedBox(height: 10),
            // 등록버튼
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onSubmit,
                icon: const Icon(Icons.edit),
                label: Text(widget.todoId == null ? '추가하기' : '수정하기'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: lightColorScheme.tertiary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDueDatePicker(TodoFormState formState, String dueText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '마감일 선택',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),

        // 날짜/시간 한 블록으로 눌러서 선택
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade400, width: 1),
          ),
          child: InkWell(
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: formState.dueDate ?? DateTime.now(),
                firstDate: DateTime(2025),
                lastDate: DateTime(2035),
              );
              if (picked != null) {
                ref.read(todoFormProvider.notifier).updateDueDate(picked);
              }
            },
            borderRadius: BorderRadius.circular(12),
            child: Row(
              children: [
                const Icon(Icons.event, color: Colors.grey),
                const SizedBox(width: 8),
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: formState.dueDate ?? DateTime.now(),
                        firstDate: DateTime(2025),
                        lastDate: DateTime(2035),
                      );
                      if (picked != null) {
                        ref
                            .read(todoFormProvider.notifier)
                            .updateDueDate(picked);
                      }
                    },
                    child: Text(dueText, style: const TextStyle(fontSize: 14)),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    final pickedTime = await showTimePicker(
                      context: context,
                      initialTime: formState.dueTime ?? TimeOfDay.now(),
                    );
                    if (pickedTime != null) {
                      ref
                          .read(todoFormProvider.notifier)
                          .updateDueTime(pickedTime);
                    }
                  },
                  child: const Text('시간 설정'),
                ),
                IconButton(
                  icon: const Icon(Icons.clear, size: 18),
                  color: Theme.of(context).colorScheme.error,
                  onPressed: () {
                    ref
                        .read(todoFormProvider.notifier)
                        .deleteDueDateAndDueTime();
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // 태그 선택
  Widget _buildTagSelector(List<String> tagOptions, TodoFormState formState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '태그 선택',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          width: double.infinity,
          child: Wrap(
            spacing: 4,
            children: tagOptions.map((tag) {
              final isSelected = formState.selectedTags.contains(tag);

              return ChoiceChip(
                showCheckmark: false,
                selectedColor: Colors.blue,
                label: Text(tag, style: TextStyle(fontWeight: FontWeight.w600)),
                selected: isSelected,
                onSelected: (selected) {
                  ref.read(todoFormProvider.notifier).toggleTag(tag);
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  // 이미지 선택
  Widget _buildImagePicker(TodoFormState formState) {
    return GestureDetector(
      onTap: () async {
        await ref.read(todoFormProvider.notifier).pickImg();
      },
      child: Stack(
        children: [
          AspectRatio(
            aspectRatio: 3 / 2,
            child: formState.imgFile == null
                ? Image.asset(
                    'assets/images/todo/default.png',
                    fit: BoxFit.cover,
                  )
                : formState.imgFile!.startsWith('assets/')
                ? Image.asset(formState.imgFile!, fit: BoxFit.cover)
                : Image.file(File(formState.imgFile!), fit: BoxFit.cover),
          ),
          // 우측 하단에 카메라 아이콘 힌트
          const Positioned(
            right: 8,
            bottom: 8,
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Colors.black54,
              child: Icon(Icons.photo_camera, color: Colors.white, size: 18),
            ),
          ),
        ],
      ),
    );
  }
}
