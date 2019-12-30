import 'package:flutter/material.dart';
import 'package:task_manager/model/TodoModel.dart';

class TodoPage extends StatefulWidget {
  TodoPage(this.title, this.todo);
  final String title;
  final TodoModel todo;

  @override
  _TodoPageState createState() => _TodoPageState(todo);
}

class _TodoPageState extends State<TodoPage> {
  _TodoPageState(this.todo);
  TodoModel todo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(todo.name),
      ),
      body: Column(
        children: <Widget>[
          Center(
            child: Text(todo.category),
          ),
          Center(
            child: Text(todo.description),
          ),
          Center(
            child: Text(todo.done.toString()),
          )
        ],
      ),
    );
  }
}
