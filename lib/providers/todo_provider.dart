import 'package:flutter/material.dart';
import 'package:task_manager/persistence/todo_table.dart';

class TodoProvider extends ChangeNotifier {
  Todo todo;
  MyDatabase _databaseProvider;
  Stream<List<Todo>> entries;

  void injectDatabaseProvider(MyDatabase databaseProvider) {
    this._databaseProvider = databaseProvider;
    entries = _databaseProvider.allTodoEntries;
  }

  Future toggleDoneFlag(Todo todo) async {
    await this._databaseProvider.toggleDoneFlag(todo);
    List<Todo> result = await this._databaseProvider.getTodoById(todo.id);
    this.todo = result[0];
    notifyListeners();
  }

  Future<Todo> getTodoById(int id) async {
    List<Todo> result = await this._databaseProvider.getTodoById(id);
    return result[0];
  }

  void removeTodo(int id) {
    _databaseProvider.removeTodo(id);
  }
}
