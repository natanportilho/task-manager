import 'package:moor_flutter/moor_flutter.dart';

part 'todo_table.g.dart';

class Todos extends Table {
  IntColumn get id => integer()();
  IntColumn get category => integer().nullable()();
  TextColumn get name => text()();
  TextColumn get description => text().named('body')();
  BoolColumnBuilder get done => boolean().named('done');
}

@DataClassName("Category")
class Categories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
}

@UseMoor(tables: [Todos, Categories])
class MyDatabase extends _$MyDatabase {
  MyDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(path: 'db.sqlite'));

  @override
  int get schemaVersion => 1;

  Future<List<Todo>> get allTodoEntries => select(todos).get();

  Stream<List<Todo>> watchEntriesInCategory(Category c) {
    return (select(todos)..where((t) => t.category.equals(c.id))).watch();
  }

  Future addTodo(Todo todo) => into(todos).insert(todo);

  Future removeTodo(int id) =>
      (delete(todos)..where((t) => t.id.equals(id))).go();


  
}
