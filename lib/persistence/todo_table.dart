import 'package:flutter/foundation.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:provider/provider.dart';

part 'todo_table.g.dart';

class Todos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get category => text()();
  TextColumn get name => text()();
  TextColumn get description => text()();
  BoolColumn get done => boolean().withDefault(Constant(true))();
}

@DataClassName("Category")
class Categories extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get imageUrl => text()();
}

@UseMoor(tables: [Todos, Categories])
class MyDatabase extends _$MyDatabase {
  MyDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(path: 'db.sqlite'));

  @override
  int get schemaVersion => 1;

  Stream<List<Todo>> get allTodoEntries => select(todos).watch();

  Stream<List<Todo>> watchEntriesInCategory(Category c) {
    return (select(todos)..where((t) => t.category.equals(c.id))).watch();
  }

  Future addTodo(Todo todo) => into(todos).insert(todo);

  Future removeTodo(int id) =>
      (delete(todos)..where((t) => t.id.equals(id))).go();

  void removeAll() => delete(todos);

  Future addCategory(Category category) => into(categories).insert(category);

  Future getCategoryById(String id) {
    return (select(categories)..where((c) => c.id.equals(id))).get();
  }
}
