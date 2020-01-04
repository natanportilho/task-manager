import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_manager/model/todo_model.dart';

class SqliteDatabase {
  SqliteDatabase() {
    db;
  }

  Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }

    _db = await initDb();
    return db;
  }

  initDb() async {
    String path = join(await getDatabasesPath(), 'todo_database.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE todo (ID STRING PRIMARY KEY, CATEGORY TEXT, NAME TEXT, DESCRIPTION TEXT, DONE BOOLEAN)');
  }

  Future<TodoModel> save(TodoModel todo) async {
    var dbClient = await db;
    dbClient.insert('todo', todo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return todo;
  }

  Future<List<TodoModel>> getTodos() async {
    var dbClient = await db;

    final List<Map<String, dynamic>> maps = await dbClient.query('todo');

    List<TodoModel> todos = [];

    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        var todoInfo = maps[i].values.toList();
        todos.add(TodoModel.fromList(todoInfo));
      }
    }
    return todos;
  }

  FutureOr<void> removeAll() async {
    var dbClient = await db;
    await dbClient.execute('DELETE FROM todo');
  }

  FutureOr<void> removeTodo(String id) async {
    var dbClient = await db;
    await dbClient.execute('DELETE FROM todo where ID = $id');
  }

  FutureOr<void> setTodoAsDone(String id) async {
    var dbClient = await db;
    await dbClient.execute('UPDATE todo SET DONE = 1 WHERE id = $id');
  }

  FutureOr<void> setTodoAsNotDone(String id) async {
    var dbClient = await db;
    await dbClient.execute('UPDATE todo SET DONE = 0 WHERE id = $id');
  }
}
