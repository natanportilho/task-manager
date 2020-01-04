import 'package:flutter/material.dart';
import 'package:task_manager/model/todo_model.dart';
import 'package:task_manager/persistence/sqlite_database.dart';

class TodoProvider extends ChangeNotifier {
  final SqliteDatabase sqliteDatabase = SqliteDatabase();
  List<TodoModel> entries = <TodoModel>[];

  initiate() {
    sqliteDatabase.getTodos().then((values) => {
          entries = values,
          notifyListeners(),
        });
  }

  addTodo(String category, String name, String description) {
    TodoModel todo = TodoModel(category, name, description);
    sqliteDatabase.save(todo);
  }

  remove(TodoModel todo) {
    sqliteDatabase.removeTodo(todo.id);
  }

  saveAsDone(TodoModel todo) {
    sqliteDatabase.setTodoAsDone(todo.id);
    todo.done = true;
  }

  saveAsNotDone(TodoModel todo) {
    sqliteDatabase.setTodoAsNotDone(todo.id);
    todo.done = false;
  }
}
