import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_manager/model/todo_model.dart';

class SqliteDatabase {
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
        'CREATE TABLE todo (ID STRING PRIMARY KEY, CATEGORY TEXT, NAME TEXT, DESCRIPTION TEXT)');
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

    print(maps);

    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        todos.add(TodoModel(maps[i]['category'], maps[i]['name'], maps[i]['description']));
      }
    }
    return todos;
  }
}
