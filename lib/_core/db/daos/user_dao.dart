import 'package:drift/drift.dart';
import 'package:todo_app/_core/db/app_database.dart';

import '../tables/user_tables.dart';

part 'user_dao.g.dart';

@DriftAccessor(tables: [Users])
class UserDao extends DatabaseAccessor<AppDatabase> with _$UserDaoMixin {
  UserDao(AppDatabase appDb) : super(appDb);

  Future<User?> getUser() {
    return (select(users)..limit(1)).getSingleOrNull();
  }

  Stream<User?> watchUser() {
    return (select(users)..limit(1)).watchSingleOrNull();
  }

  Future<int> insertUser(UsersCompanion data) {
    return into(users).insert(data);
  }

  Future<bool> updateUser(UsersCompanion data) {
    return update(users).replace(data);
  }

  Future<int> deleteUser(int id) {
    return (delete(users)..where((user) => user.id.equals(id))).go();
  }
}
