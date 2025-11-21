class Todo {
  final int? id;
  final String title;
  final String? todoImg;
  final List<String> tags;
  final DateTime? createAt;
  final DateTime? updateAt;

  Todo({
    required this.id,
    required this.title,
    this.todoImg,
    this.tags = const [],
    this.createAt,
    this.updateAt,
  });

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'],
      title: map['title'],
      todoImg: map['todoImg'],
      tags: List<String>.from(map['tags'] ?? []),
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
