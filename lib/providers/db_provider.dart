// lib/providers/db_providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/_core/db/app_database.dart';
import 'package:todo_app/_core/db/daos/todo_dao.dart';

// DB인스턴스
final databaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});
// DAO 인스턴스
final todoDaoProvider = Provider<TodoDao>((ref) {
  final db = ref.watch(databaseProvider);
  return db.todoDao;
});
// list
final todoListProvider = StreamProvider((ref) {
  final dao = ref.watch(todoDaoProvider);
  return dao.watchTodos();
});
// deatil
final todoDetailProvider = StreamProvider.family((ref, int id) {
  final dao = ref.watch(todoDaoProvider);
  return dao.watchTodoById(id);
});
