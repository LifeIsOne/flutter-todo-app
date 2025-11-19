class Todo {
  late int? id;
  late String title;
  late String? todoImg;
  late DateTime? createAt;
  late DateTime? updateAt;

  Todo({
    this.id,
    required this.title,
    this.todoImg,
    this.createAt,
    this.updateAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'todoImg': todoImg,
      'createAt': createAt,
      'updateAt': updateAt,
    };
  }

  Todo.fromMap(Map<String, dynamic>? map) {
    id = map?['id'];
    title = map?['title'];
    todoImg = map?['todoImg'];
    createAt = map?['createAt'];
    updateAt = map?['updateAt'];
  }
}
