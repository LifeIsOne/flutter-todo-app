import 'package:drift/drift.dart';

class Tags extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text().withLength(min: 2, max: 10)();

  @override
  List<Set<Column>> get uniqueKeys => [
    {name},
  ];
}
