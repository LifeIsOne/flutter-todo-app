import 'dart:convert';

import 'package:drift/drift.dart';

class Todo extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text()();

  TextColumn get todoImg => text().nullable()();

  TextColumn get tags => text().map(const StringListConverter()).nullable()();

  DateTimeColumn get dueDate => dateTime().nullable()();

  DateTimeColumn get createAt =>
      dateTime().clientDefault(() => DateTime.now().toUtc())();

  DateTimeColumn get updateAt =>
      dateTime().clientDefault(() => DateTime.now().toUtc())();
}

class StringListConverter extends TypeConverter<List<String>, String> {
  const StringListConverter();

  @override
  List<String> fromSql(String fromDb) {
    return List<String>.from(jsonDecode(fromDb));
  }

  @override
  String toSql(List<String> value) {
    return jsonEncode(value);
  }
}
