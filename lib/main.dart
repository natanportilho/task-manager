import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/providers/todo_provider.dart';

import 'pages/home_page.dart';

void main() => runApp(ChangeNotifierProvider<TodoProvider>(
      create: (_) => TodoProvider(),
      child: MyApp(),
    ));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Home Page'),
    );
  }
}
