import 'package:drift/drift.dart';
import 'package:todo_app/_core/db/app_database.dart';
import 'package:todo_app/_core/db/tables/tag_tables.dart';
import 'package:todo_app/_core/db/tables/todo_tables.dart';
import 'package:todo_app/_core/db/tables/todo_tag_tables.dart';

part 'tag_dao.g.dart';

@DriftAccessor(tables: [Tags, TodoTags, Todo])
class TagDao extends DatabaseAccessor<AppDatabase> with _$TagDaoMixin {
  TagDao(AppDatabase db) : super(db);

  Future<List<Tag>> getAllTags() {
    return select(tags).get();
  }

  Stream<List<Tag>> watchTags() {
    return select(tags).watch();
  }

  Future<Tag> getTagById(int id) {
    return (select(tags)..where((tag) => tag.id.equals(id))).getSingle();
  }

  Future<int> insertTag(TagsCompanion data) {
    return into(tags).insert(data);
  }

  Future<bool> updateTag(TagsCompanion data) {
    return update(tags).replace(data);
  }

  Future<int> deleteTag(int id) {
    return (delete(tags)..where((tag) => tag.id.equals(id))).go();
  }

  // -------------------- Todo - Tag 연결 --------------------

  Future<void> setTagsForTodo(int todoId, List<int> tagIds) async {
    // 기존 연결 삭제
    await (delete(todoTags)..where((tag) => tag.todoId.equals(todoId))).go();

    // 새 연결 삽입
    if (tagIds.isEmpty) return;

    await batch((batch) {
      batch.insertAll(
        todoTags,
        tagIds
            .map(
              (tagId) => TodoTagsCompanion.insert(todoId: todoId, tagId: tagId),
            )
            .toList(),
      );
    });
  }

  Future<List<Tag>> getTagsForTodo(int todoId) async {
    final query = select(tags).join([
      innerJoin(todoTags, todoTags.tagId.equalsExp(tags.id)),
    ])..where(todoTags.todoId.equals(todoId));

    final rows = await query.get();
    return rows.map((row) => row.readTable(tags)).toList();
  }

  Future<List<TodoData>> getTodosForTag(int tagId) async {
    final query = select(todo).join([
      innerJoin(todoTags, todoTags.todoId.equalsExp(todo.id)),
    ])..where(todoTags.tagId.equals(tagId));

    final rows = await query.get();
    return rows.map((row) => row.readTable(todo)).toList();
  }
}
