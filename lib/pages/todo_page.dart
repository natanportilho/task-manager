import 'package:flutter/material.dart';
import 'package:task_manager/model/TodoModel.dart';

class TodoPage extends StatefulWidget {
  TodoPage(this.title, this.todo);
  String title;
  TodoModel todo;

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
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}
