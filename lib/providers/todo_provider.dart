import 'package:flutter/material.dart';
import 'package:task_manager/persistence/todo_table.dart';

class TodoProvider extends ChangeNotifier {
  Stream<List<Todo>> entries;

  void update(MyDatabase databaseProvider) {
    entries = databaseProvider.allTodoEntries;
  }
}
