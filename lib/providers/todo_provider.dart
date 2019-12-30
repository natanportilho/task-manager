import 'package:flutter/material.dart';
import 'package:task_manager/model/TodoModel.dart';

class TodoProvider extends ChangeNotifier {
  final List<TodoModel> entries = <TodoModel>[];

  addTodo(String category, String name, String description) {
    entries.add(TodoModel(category, name, description));
    notifyListeners();
  }

  remove(TodoModel todo) {
    entries.remove(todo);
    notifyListeners();
  }

  saveAdDone(TodoModel todo) {
    int index = entries.indexOf(todo);
    entries[index].done = true;
    notifyListeners();
  }

  saveAsNotDone(TodoModel todo) {
    int index = entries.indexOf(todo);
    entries[index].done = false;
    notifyListeners();
  }
}
