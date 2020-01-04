import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/persistence/todo_table.dart';
import 'package:task_manager/providers/category_dropdown_provider.dart';

import 'pages/home_page.dart';

void main() => runApp(MultiProvider(providers: [
      Provider<MyDatabase>(create: (_) => MyDatabase()),
      ChangeNotifierProvider<CategoryDropdownProvider>(
          create: (_) => CategoryDropdownProvider())
    ], child: MyApp()));

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
