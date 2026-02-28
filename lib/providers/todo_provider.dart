import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:todo_app/_core/db/app_database.dart';
import 'package:todo_app/providers/db_provider.dart';

final todoSearchTermProvider = StateProvider<String>((ref) => '');
final todoSelectedTagProvider = StateProvider<String?>((ref) => null);

final filteredTodoListProvider = Provider<AsyncValue<List<Todo>>>((ref) {
  final todosAsync = ref.watch(todoListProvider);
  final searchTerm = ref.watch(todoSearchTermProvider);
  final selectedTag = ref.watch(todoSelectedTagProvider);

  return todosAsync.when(
    data: (todos) {
      final filtered = todos.where((todo) {
        final tagMatch =
            selectedTag == null || (todo.tags?.contains(selectedTag) ?? false);
        final searchMatch =
            searchTerm.isEmpty ||
            todo.title.toLowerCase().contains(searchTerm.toLowerCase());
        return tagMatch && searchMatch;
      }).toList();
      return AsyncValue.data(filtered);
    },
    loading: () => const AsyncValue.loading(),
    error: (error, stackTrace) => AsyncValue.error(error, stackTrace),
  );
});
