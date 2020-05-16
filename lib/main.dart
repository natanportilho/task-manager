import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/persistence/todo_table.dart';
import 'package:task_manager/providers/category_provider.dart';
import 'package:task_manager/providers/todo_provider.dart';
import 'package:task_manager/stores/store_category.dart';
import 'package:task_manager/stores/task_store.dart';
import 'package:dynamic_theme/dynamic_theme.dart';

import 'pages/home_page.dart';

void main() => runApp(MultiProvider(providers: [
      Provider(
        create: (_) => MyDatabase(),
      ),
      ChangeNotifierProxyProvider<MyDatabase, TodoProvider>(
          create: (_) => TodoProvider(),
          update: (_, myDatabase, todoProvider) => todoProvider),
      ChangeNotifierProvider<CategoryProvider>(
          create: (_) => CategoryProvider()),
      Provider<TaskStore>(create: (_) => TaskStore()),
      Provider<CategoryStore>(create: (_) => CategoryStore())
    ], child: MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MyDatabase databaseProvider = Provider.of<MyDatabase>(context);
    databaseProvider.insertInitialCategories();
    return new DynamicTheme(
        defaultBrightness: Brightness.light,
        data: (brightness) => new ThemeData(
              primarySwatch: Colors.indigo,
              brightness: brightness,
            ),
        themedWidgetBuilder: (context, theme) {
          return new MaterialApp(
            title: 'Flutter Demo',
            theme: theme,
            home: MyHomePage(title: 'Home Page'),
          );
        });
  }
}
