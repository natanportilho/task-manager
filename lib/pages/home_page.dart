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
          child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: todoProvider.entries.length,
              itemBuilder: (BuildContext context, int index) {
                var todo = todoProvider.entries[index].todo;
                return InkWell(
                  onTap: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TodoPage(todo.name, todo),
                        ))
                  },
                  child: Container(
                    height: 70,
                    color: Colors.amber[colorCodes[0]],
                    child: Center(child: todoProvider.entries[index]),
                  ),
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
