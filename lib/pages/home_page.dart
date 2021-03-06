import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/pages/create_todo_page.dart';
import 'package:task_manager/pages/theme_selection_page.dart';
import 'package:task_manager/pages/todo_page.dart';
import 'package:task_manager/services/firebase_service.dart';
import 'package:task_manager/stores/task_store.dart';
import 'package:task_manager/models/task_model.dart';

class MyHomePage extends StatefulWidget {
  FirebaseService firebaseService;
  MyHomePage(FirebaseService firebaseService) {
    this.firebaseService = firebaseService;
  }

  // MyHomePage(FirebaseFirestore instance, {Key key, this.title})
  //     : super(key: key);
  // final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState(firebaseService);
}

class _MyHomePageState extends State<MyHomePage> {
  FirebaseService firebaseService;
  _MyHomePageState(FirebaseService firebaseService) {
    this.firebaseService = firebaseService;
  }

  TaskStore taskStore;

  @override
  Widget build(BuildContext context) {
    taskStore = Provider.of<TaskStore>(context);
    // taskStore.firebase = firebase;

    return Scaffold(
      appBar: _buildAppBar(context),
      body: Center(
          child: Observer(
        builder: (_) => _buildListView(),
      )),
      floatingActionButton: _createTodoButton(context),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
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

  ListView _buildListView() {
    List<Task> myTodos = taskStore.todos.data;

    if (myTodos == null) {
      myTodos = List<Task>();
    }

    return ListView.separated(
        itemCount: myTodos.length,
        separatorBuilder: (BuildContext context, int index) => Divider(
              height: 2,
            ),
        itemBuilder: (BuildContext context, int index) {
          var task = myTodos[index];

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
        title: Text(todo.description.length >= 10
            ? todo.description.substring(0, 10) + '...'
            : todo.description),
        onTap: () => {_goToTodoPage(context, todo)},
        subtitle: Text(todo.category.name.toString()),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              icon: Icon(
                todo.important ? Icons.star : Icons.star_border,
                size: 20.0,
                color: Colors.brown[900],
              ),
              onPressed: () {
                taskStore
                    .toggleImportant(todo); //   _onDeleteItemPressed(index);
              },
            )
          ],
        ));
  }

  Future _goToTodoPage(BuildContext context, Task todo) {
    return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TodoPage(todo),
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
