import 'package:drift/drift.dart';

class Users extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();

  TextColumn get profileImg => text().nullable()();

  DateTimeColumn get createAt =>
      dateTime().clientDefault(() => DateTime.now().toUtc())();

  DateTimeColumn get updateAt =>
      dateTime().clientDefault(() => DateTime.now().toUtc())();
}
