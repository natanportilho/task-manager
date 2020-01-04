import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/model/todo_model.dart';
import 'package:task_manager/pages/create_todo_page.dart';
import 'package:task_manager/pages/todo_page.dart';
import 'package:task_manager/providers/todo_provider.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final TodoProvider todoProvider = Provider.of<TodoProvider>(context);
    todoProvider.initiate();

    return Scaffold(
      appBar: _buildAppBar(),
      body: Center(child: _buildListView(todoProvider)),
      floatingActionButton: _createTodoButton(context),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.greenAccent[700],
      title: Text(widget.title),
    );
  }

  ListView _buildListView(TodoProvider todoProvider) {
    return ListView.separated(
        itemCount: todoProvider.entries.length,
        separatorBuilder: (BuildContext context, int index) => Divider(),
        itemBuilder: (BuildContext context, int index) {
          var todo = todoProvider.entries[index];
          return Container(
            color: todo.done ? Colors.greenAccent[100] : Colors.green[50],
            child: _buildListTile(todo, context),
          );
        });
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

  ListTile _buildListTile(TodoModel todo, BuildContext context) {
    return ListTile(
      title: Text(todo.name),
      onTap: () => {_goToTodoPage(context, todo)},
      subtitle: Text(todo.category),
    );
  }

  Future _goToTodoPage(BuildContext context, TodoModel todo) {
    return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TodoPage(todo.name, todo),
        ));
  }
}
