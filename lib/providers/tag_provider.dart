import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/_core/db/app_database.dart';
import 'package:todo_app/_core/db/daos/tag_dao.dart';
import 'package:todo_app/providers/db_provider.dart';

final tagDaoProvider = Provider<TagDao>((ref) {
  final db = ref.watch(databaseProvider);
  return db.tagDao;
});

final tagListProvider = StreamProvider<List<Tag>>((ref) {
  final dao = ref.watch(tagDaoProvider);
  return dao.watchTags();
});
