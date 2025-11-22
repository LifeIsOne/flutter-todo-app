// lib/providers/db_providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/_core/db/app_database.dart';
import 'package:todo_app/_core/db/daos/todo_dao.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

final todoDaoProvider = Provider<TodoDao>((ref) {
  final db = ref.watch(databaseProvider);
  return db.todoDao;
});

final todoListProvider = StreamProvider((ref) {
  final dao = ref.watch(todoDaoProvider);
  return dao.watchTodos();
});
