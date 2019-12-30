import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/model/TodoModel.dart';
import 'package:task_manager/providers/todo_provider.dart';

class TodoPage extends StatefulWidget {
  TodoPage(this.title, this.todo);
  final String title;
  final TodoModel todo;

  @override
  _TodoPageState createState() => _TodoPageState(todo);
}

class _TodoPageState extends State<TodoPage> {
  _TodoPageState(this.todo);
  TodoModel todo;

  @override
  Widget build(BuildContext context) {
    final TodoProvider todoProvider = Provider.of<TodoProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(todo.name),
      ),
      body: Column(
        children: <Widget>[
          Center(
            child: Text(
              todo.name,
              style: TextStyle(fontSize: 36),
            ),
          ),
          _buildCircleAvatar(todo),
          Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(
              child: Text(todo.description),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(onPressed: () => {}, icon: Icon(Icons.play_arrow)),
              IconButton(onPressed: () => {}, icon: Icon(Icons.done)),
              IconButton(
                  onPressed: () =>
                      {todoProvider.remove(todo), Navigator.pop(context)},
                  icon: Icon(Icons.delete)),
            ],
          ),
        ],
      ),
    );
  }

  CircleAvatar _buildCircleAvatar(TodoModel todo) {
    String imageUrl = '';
    print(todo.category);
    if (todo.category == 'Work') {
      imageUrl =
          'https://images.unsplash.com/photo-1494498902093-87f291949d17?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60';
    } else if (todo.category == 'Study') {
      imageUrl =
          'https://images.unsplash.com/photo-1537202108838-e7072bad1927?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=685&q=80';
    } else {
      imageUrl =
          'https://images.unsplash.com/photo-1462926703708-44ab9e271d97?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=564&q=80';
    }

    return CircleAvatar(
      backgroundImage: NetworkImage(imageUrl),
      radius: 80,
    );
  }
}
