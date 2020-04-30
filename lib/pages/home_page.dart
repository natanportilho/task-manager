import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/pages/create_todo_page.dart';
import 'package:task_manager/pages/theme_selection_page.dart';
import 'package:task_manager/pages/todo_page.dart';
import 'package:task_manager/persistence/todo_table.dart';
import 'package:task_manager/providers/color_theme_provider.dart';
import 'package:task_manager/providers/todo_provider.dart';
import 'package:task_manager/repositories/todo_repository.dart';
import 'package:task_manager/repositories/todo_repository_interface.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MyDatabase databaseProvider;
  TodoProvider todoProvider;
  ColorThemeProvider colorThemeProvider;

  @override
  Widget build(BuildContext context) {

    List<Todo> entries = <Todo>[];
    colorThemeProvider = Provider.of<ColorThemeProvider>(context);
    colorThemeProvider.init();
    databaseProvider = Provider.of<MyDatabase>(context);
    todoProvider = Provider.of<TodoProvider>(context);
    todoProvider.injectDatabaseProvider(databaseProvider);

    return Scaffold(
      appBar: _buildAppBar(),
      body: Center(
          child: StreamBuilder<List<Todo>>(
              stream: todoProvider.entries,
              initialData: entries,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return _buildListView(snapshot.data);
                }
              })),
      floatingActionButton: _createTodoButton(context),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: colorThemeProvider.color == null ? Colors.green : colorThemeProvider.color.primaryColor,
      title: Text(widget.title),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.color_lens),
          onPressed: () => {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ThemeSelectionPage(),
                )),
          },
        )
      ],
    );
  }

  ListView _buildListView(List<Todo> entries) {
    Color doneColor = colorThemeProvider.color != null ? colorThemeProvider.color.secondaryColor : Colors.greenAccent[100];
    Color notDoneColor = colorThemeProvider.color != null ? colorThemeProvider.color.thirdColor : Colors.greenAccent[50];

    return ListView.separated(
        itemCount: entries.length,
        separatorBuilder: (BuildContext context, int index) => Divider(),
        itemBuilder: (BuildContext context, int index) {
          var todo = entries[index];
          return Container(
            color: todo.done ? doneColor : notDoneColor,
            child: _buildListTile(todo, context),
          );
        });
    // });
  }

  FloatingActionButton _createTodoButton(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: colorThemeProvider.color == null ? Colors.green : colorThemeProvider.color.primaryColor,
      onPressed: () => {_goToCreateTodoPage(context)},
      tooltip: 'Create Todo',
      child: Icon(Icons.add),
    );
  }

  Future _goToCreateTodoPage(BuildContext context) {
    return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CreateTodoPage(),
        ));
  }

  ListTile _buildListTile(Todo todo, BuildContext context) {
    return ListTile(
      title: Text(todo.name),
      onTap: () => {_goToTodoPage(context, todo)},
      subtitle: Text(todo.category.toString()),
    );
  }

  Future _goToTodoPage(BuildContext context, Todo todo) {
    return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TodoPage(todo.name, todo),
        ));
  }
}
