import 'package:flutter/material.dart';
import 'package:task_manager/model/TodoModel.dart';
import 'package:task_manager/widgets/todo.dart';

class TodoProvider extends ChangeNotifier {
  final List<Todo> entries = <Todo>[];

  addTodo(String category, String name, String description) {
    entries.add(Todo(TodoModel(category, name, description)));
    notifyListeners();
  }

  remove(TodoModel todo) {
    entries.remove(Todo(todo));
    notifyListeners();
  }
}
