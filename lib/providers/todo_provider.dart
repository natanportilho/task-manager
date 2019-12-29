import 'package:flutter/material.dart';
import 'package:task_manager/model/TodoModel.dart';
import 'package:task_manager/widgets/todo.dart';


class TodoProvider extends ChangeNotifier {
  final List<Todo> entries = <Todo>[];

  addTodo() {
    entries.add(Todo(TodoModel('Category','Name','Description')));
    notifyListeners();
  }
}
