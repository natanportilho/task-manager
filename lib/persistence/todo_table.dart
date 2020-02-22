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

  Future toggleDoneFlag(Todo todo) async {
    return await this.transaction(
      () => (update(todos)..where((t) => t.id.equals(todo.id))).write(
        TodosCompanion(
          done: todo.done ? Value(false) : Value(true),
        ),
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

  Future updateTodoDescription(int id, String description) async {
    return await this
        .transaction(() => (update(todos)..where((t) => t.id.equals(id))).write(
              TodosCompanion(
                description: Value(description),
              ),
            ));
  }

  Future addTodo(Todo todo) async {
    await this.transaction(() => into(todos).insert(todo));
  }

  Future removeTodo(int id) async {
    await this
        .transaction(() => (delete(todos)..where((t) => t.id.equals(id))).go());
  }

  void removeAll() async => delete(todos);

  Future addCategory(Category category) async {
    return await this.transaction(() => into(categories).insert(category));
  }

  Future<List<Category>> getCategoryById(String id) async {
    return await (select(categories)..where((c) => c.id.equals(id))).get();
  }

  Future<List<Todo>> getTodoById(int id) async {
    return await (select(todos)..where((t) => t.id.equals(id))).get();
  }

  Future insertInitialCategories() async {
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

    await into(categories).insert(personal);
    await into(categories).insert(work);
    await into(categories).insert(study);
  }

  Future updateTodoCategory(todoId, categoryId) async {
    return await this.transaction(
      () => (update(todos)..where((t) => t.id.equals(todoId))).write(
        TodosCompanion(
          category: Value(categoryId),
        ),
      ),
    );
  }
}
