import 'package:flutter/material.dart';
import 'package:task_manager/models/task_model.dart';
import 'package:task_manager/stores/task_store.dart';

class AlarmPage extends StatefulWidget {
  AlarmPage(this.todo);
  final Task todo;

  @override
  _AlarmPageState createState() => _AlarmPageState(todo);
}

class _AlarmPageState extends State<AlarmPage> {
  TaskStore taskStore;
  _AlarmPageState(this.todo);
  Task todo;
  List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(),
            body: Material(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(),
              ),
            )));
  }

  AppBar buildAppBar() {
    return AppBar();
  }
}
