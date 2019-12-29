import 'package:flutter/material.dart';
import 'package:task_manager/model/TodoModel.dart';

class Todo extends StatelessWidget {
  final TodoModel todo;

  Todo(this.todo);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(todo.category),
          Text(todo.name),
          Text(todo.description)
        ],
      ),
    );
  }
}
