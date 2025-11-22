class Todo {
  final int? id;
  final String title;
  final String? todoImg;
  final List<String> tags;
  final DateTime? dueDate;
  final DateTime? createAt;
  final DateTime? updateAt;

  Todo({
    required this.id,
    required this.title,
    this.todoImg,
    this.tags = const [],
    this.dueDate,
    this.createAt,
    this.updateAt,
  });

  String get defaultImg {
    return todoImg ?? 'assets/images/todo/default.png';
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'],
      title: map['title'],
      todoImg: map['todoImg'],
      tags: List<String>.from(map['tags'] ?? []),
      dueDate: map['dueDate'],
      createAt: map['createAt'],
      updateAt: map['updateAt'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'todoImg': todoImg,
      'tags': tags,
      'dueDate': dueDate,
      'createAt': createAt,
      'updateAt': updateAt,
    };
  }

  // Todo.fromMap(Map<String, dynamic>? map) {
  //   id = map?['id'];
  //   title = map?['title'];
  //   todoImg = map?['todoImg'];
  //   tag = map?['tag'];
  //   createAt = map?['createAt'];
  //   updateAt = map?['updateAt'];
  // }
}
