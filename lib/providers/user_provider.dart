import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/_core/db/app_database.dart';
import 'package:todo_app/_core/db/daos/user_dao.dart';
import 'package:todo_app/providers/db_provider.dart';

final userStateProvider = StreamProvider<User?>((ref) {
  final dao = ref.watch(userDaoProvider);
  return dao.watchUser();
});

final userControllerProvider = Provider<UserController>((ref) {
  final dao = ref.watch(userDaoProvider);
  return UserController(dao);
});

class UserController {
  final UserDao userDao;

  UserController(this.userDao);

  // Future<void> addUser(String name) async {
  //   final companion = UsersCompanion.insert(name: name);
  //   await userDao.insertUser(companion);
  // }

  // 사용자 한 명으로 업데이트만
  Future<void> updateUser({String? name, String? profileImg}) async {
    final companion = UsersCompanion(
      id: Value(1),
      name: name != null ? Value(name) : const Value.absent(),
      profileImg: profileImg != null ? Value(profileImg) : const Value.absent(),
      updateAt: Value(DateTime.now()),
    );

    await userDao.updateUser(companion);
  }
}
