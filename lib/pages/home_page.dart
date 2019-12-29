import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    final List<int> colorCodes = <int>[600, 500, 100];
    final TodoProvider todoProvider = Provider.of<TodoProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: ListView.separated(
              itemCount: todoProvider.entries.length,
              separatorBuilder: (BuildContext context, int index) => Divider(),
              itemBuilder: (BuildContext context, int index) {
                var todo = todoProvider.entries[index].todo;
                return ListTile(
                  title: Text(todo.name),
                  onTap: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TodoPage(todo.name, todo),
                        ))
                  },
                );
              })),
      floatingActionButton: FloatingActionButton(
        onPressed: todoProvider.addTodo,
        tooltip: 'Create Todo',
        child: Icon(Icons.add),
      ),
    );
  }
}
