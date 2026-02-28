import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/models/todo_form_state.dart';

class TodoFormNotifier extends Notifier<TodoFormState> {
  @override
  TodoFormState build() {
    return TodoFormState(title: '', selectedTags: []);
  }

  // title 변경
  void updateTitle(String formTitle) {
    state = state.copyWith(title: formTitle);
  }

  // imgFile 변경
  Future<void> pickImg() async {
    // TODO : 나중에 작성
  }

  // tag 토글
  void toggleTag(String formTag) {
    final current = List<String>.from(state.selectedTags);

    if (!current.contains(formTag)) {
      current.add(formTag);
    } else {
      current.remove(formTag);
    }

    state = state.copyWith(selectedTags: current);
  }

  // dueDate 변경
  void updateDueDate(DateTime formDate) {
    state = state.copyWith(dueDate: formDate);
  }

  // dueTime 변경
  void updateDueTime(TimeOfDay formTime) {
    state = state.copyWith(dueTime: formTime);
  }

  // dueDate, dueTime 제거
  void deleteDueDate() {
    state = state.copyWith(dueDate: null, dueTime: null);
  }

  // 수정화면 form
  void initWithTodo({
    String? imgFile,
    List<String> selectedTags = const [],
    DateTime? dueDate,
  }) {
    state = state.copyWith(
      imgFile: imgFile,
      selectedTags: selectedTags,
      dueDate: dueDate,
    );
  }
}

final todoFormProvider =
    NotifierProvider.autoDispose<TodoFormNotifier, TodoFormState>(
      () => TodoFormNotifier(),
    );
