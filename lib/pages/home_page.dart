import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/pages/create_todo_page.dart';
import 'package:task_manager/pages/theme_selection_page.dart';
import 'package:task_manager/pages/todo_page.dart';
import 'package:task_manager/persistence/todo_table.dart';
import 'package:task_manager/providers/color_theme_provider.dart';
import 'package:task_manager/providers/todo_provider.dart';
import 'package:task_manager/stores/task_store.dart';
import 'package:task_manager/models/task_model.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TaskStore taskStore;
  MyDatabase databaseProvider;
  TodoProvider todoProvider;
  ColorThemeProvider colorThemeProvider;

  @override
  Widget build(BuildContext context) {
    taskStore = Provider.of<TaskStore>(context);
    colorThemeProvider = Provider.of<ColorThemeProvider>(context);
    colorThemeProvider.init();
    databaseProvider = Provider.of<MyDatabase>(context);
    todoProvider = Provider.of<TodoProvider>(context);
    todoProvider.injectDatabaseProvider(databaseProvider);

    return Scaffold(
      appBar: _buildAppBar(context),
      body: Center(
          child: Observer(
        builder: (_) => _buildListView(taskStore.tasks),
      )),
      floatingActionButton: _createTodoButton(context),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    TaskStore taskStore = Provider.of<TaskStore>(context);

    return AppBar(
      backgroundColor: colorThemeProvider.color == null
          ? Colors.green
          : colorThemeProvider.color.primaryColor,
      title: Observer(
        builder: (_) => Text(taskStore.tasks.length.toString()),
      ),
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

  ListView _buildListView(List<Task> entries) {
    Color doneColor = colorThemeProvider.color != null
        ? colorThemeProvider.color.secondaryColor
        : Colors.greenAccent[100];
    Color notDoneColor = colorThemeProvider.color != null
        ? colorThemeProvider.color.thirdColor
        : Colors.greenAccent[50];

    return ListView.separated(
        itemCount: taskStore.tasks.length,
        separatorBuilder: (BuildContext context, int index) => Divider(),
        itemBuilder: (BuildContext context, int index) {
          var task = taskStore.tasks[index];

          return Container(
            color: task.done ? doneColor : notDoneColor,
            child: _buildListTile(task, context),
          );
        });
    // });
  }

  FloatingActionButton _createTodoButton(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: colorThemeProvider.color == null
          ? Colors.green
          : colorThemeProvider.color.primaryColor,
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

  ListTile _buildListTile(Task todo, BuildContext context) {
    return ListTile(
      title: Text(todo.name),
      onTap: () => {_goToTodoPage(context, todo)},
      subtitle: Text(todo.category.name.toString()),
    );
  }

  Future _goToTodoPage(BuildContext context, Task todo) {
    return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TodoPage(todo.name, todo),
        ));
  }
}
