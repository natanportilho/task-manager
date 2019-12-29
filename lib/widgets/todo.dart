import 'package:flutter/material.dart';
import 'package:task_manager/model/TodoModel.dart';

class Todo extends StatelessWidget {
  TodoModel _todo;

  Todo(TodoModel todo) {
    this._todo = todo;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(_todo.category),
          Text(_todo.name),
          Text(_todo.description)
        ],
      ),
    );
  }
}
