import 'package:flutter/material.dart';

class TodoFormState {
  final String title;
  final String? imgFile;
  final List<String> selectedTags;
  final DateTime? dueDate;
  final TimeOfDay? dueTime;

  //<editor-fold desc="Data Methods">
  const TodoFormState({
    required this.title,
    this.imgFile,
    required this.selectedTags,
    this.dueDate,
    this.dueTime,
  });

  // 연산자 재정의
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TodoFormState &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          imgFile == other.imgFile &&
          selectedTags == other.selectedTags &&
          dueDate == other.dueDate &&
          dueTime == other.dueTime);

  // 해시코드를 사용 해 안정적인 상태 감지
  @override
  int get hashCode =>
      title.hashCode ^
      imgFile.hashCode ^
      selectedTags.hashCode ^
      dueDate.hashCode ^
      dueTime.hashCode;

  // toString 
  @override
  String toString() {
    return 'TodoFormState{' +
        ' title: $title,' +
        ' imgFile: $imgFile,' +
        ' selectedTags: $selectedTags,' +
        ' dueDate: $dueDate,' +
        ' dueTime: $dueTime,' +
        '}';
  }

  TodoFormState copyWith({
    String? title,
    String? imgFile,
    List<String>? selectedTags,
    DateTime? dueDate,
    TimeOfDay? dueTime,
  }) {
    return TodoFormState(
      title: title ?? this.title,
      imgFile: imgFile ?? this.imgFile,
      selectedTags: selectedTags ?? this.selectedTags,
      dueDate: dueDate ?? this.dueDate,
      dueTime: dueTime ?? this.dueTime,
    );
  }

  // 데이터를 JSON 형태로 바꾸고, SharedPreferences에 저장할 때 변환 도구
  Map<String, dynamic> toMap() {
    return {
      'title': this.title,
      'imgFile': this.imgFile,
      'selectedTags': this.selectedTags,
      'dueDate': this.dueDate,
      'dueTime': this.dueTime,
    };
  }

  factory TodoFormState.fromMap(Map<String, dynamic> map) {
    return TodoFormState(
      title: map['title'] as String,
      imgFile: map['imgFile'] as String,
      selectedTags: map['selectedTags'] as List<String>,
      dueDate: map['dueDate'] as DateTime,
      dueTime: map['dueTime'] as TimeOfDay,
    );
  }
  //</editor-fold>
}