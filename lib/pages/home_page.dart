import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/pages/create_todo_page.dart';
import 'package:task_manager/pages/theme_selection_page.dart';
import 'package:task_manager/pages/todo_page.dart';
import 'package:task_manager/repositories/todo_repository.dart';
import 'package:task_manager/repositories/todo_repository_interface.dart';
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

  ITodoRepository todoRepository = TodoRepository();

  @override
  Widget build(BuildContext context) {
    taskStore = Provider.of<TaskStore>(context);

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
    return AppBar(
      title: Text("Homepage"),
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
    List<Task> myTodos = taskStore.todos.data;

    myTodos.forEach((element) {
      print(element.description);
    });

    return ListView.separated(
        itemCount: taskStore.tasks.length,
        separatorBuilder: (BuildContext context, int index) => Divider(
              height: 2,
            ),
        itemBuilder: (BuildContext context, int index) {
          var task = taskStore.tasks[index];

          return Observer(
            builder: (_) => Container(
              color: _changeDoneColor(task, context),
              child: _buildListTile(task, context),
            ),
          );
        });
  }

  FloatingActionButton _createTodoButton(BuildContext context) {
    return FloatingActionButton(
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

  Color _changeDoneColor(Task task, BuildContext context) {
    if (task.done) {
      return Theme.of(context).accentColor;
    } else {
      return Colors.white;
    }
  }
}
