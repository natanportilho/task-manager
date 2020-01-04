import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/pages/create_todo_page.dart';
import 'package:task_manager/pages/todo_page.dart';
import 'package:task_manager/persistence/todo_table.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MyDatabase databaseProvider;

  @override
  Widget build(BuildContext context) {
    databaseProvider = Provider.of<MyDatabase>(context);

    // databaseProvider.removeAll();
    return Scaffold(
      appBar: _buildAppBar(),
      body: Center(
          child: StreamBuilder<List<Todo>>(
              stream: databaseProvider.allTodoEntries,
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
      backgroundColor: Colors.greenAccent[700],
      title: Text(widget.title),
    );
  }

  ListView _buildListView(List<Todo> entries) {

    return ListView.separated(
        itemCount: entries.length,
        separatorBuilder: (BuildContext context, int index) => Divider(),
        itemBuilder: (BuildContext context, int index) {
          var todo = entries[index];
          return Container(
            color: todo.done ? Colors.greenAccent[100] : Colors.green[50],
            child: _buildListTile(todo, context),
          );
        });
    // });
  }

  FloatingActionButton _createTodoButton(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.greenAccent[700],
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
