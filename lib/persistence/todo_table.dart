import 'package:flutter/foundation.dart';
import 'package:moor_flutter/moor_flutter.dart';

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

  Future toggleDoneFlag(Todo todo) {
    return (update(todos)..where((t) => t.id.equals(todo.id))).write(
      TodosCompanion(
        done: todo.done ? Value(false) : Value(true),
      ),
    );
  }

  Stream<List<Todo>> watchEntriesInCategory(Category c) {
    return (select(todos)..where((t) => t.category.equals(c.id))).watch();
  }

  Future<List<Category>> getAllCategories() {
    //TODO: Should check this. Checking for distinct because some categories are being duplicates.
    return (select(categories, distinct: true)
          ..orderBy([(c) => OrderingTerm(expression: c.id)]))
        .get();
  }

  Future updateTodoDescription(int id, String description) {
    return (update(todos)..where((t) => t.id.equals(id))).write(
      TodosCompanion(
        description: Value(description),
      ),
    );
  }

  Future addTodo(Todo todo) => into(todos).insert(todo);

  Future removeTodo(int id) =>
      (delete(todos)..where((t) => t.id.equals(id))).go();

  void removeAll() => delete(todos);

  Future addCategory(Category category) => into(categories).insert(category);

  Future<List<Category>> getCategoryById(String id) {
    return (select(categories)..where((c) => c.id.equals(id))).get();
  }

  Future<List<Todo>> getTodoById(int id) {
    return (select(todos)..where((t) => t.id.equals(id))).get();
  }

  Future insertInitialCategories() {
    Category personal = Category(
        id: 'Personal',
        name: 'Personal',
        imageUrl:
            'https://images.unsplash.com/photo-1462926703708-44ab9e271d97?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=564&q=80');
    Category work = Category(
        id: 'Work',
        name: 'Work',
        imageUrl:
            'https://images.unsplash.com/photo-1494498902093-87f291949d17?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60');
    Category study = Category(
        id: 'Study',
        name: 'Study',
        imageUrl:
            'https://images.unsplash.com/photo-1537202108838-e7072bad1927?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=685&q=80');

    into(categories).insert(personal);
    into(categories).insert(work);
    into(categories).insert(study);
  }
}
