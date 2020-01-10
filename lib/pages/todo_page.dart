import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/persistence/todo_table.dart';
import 'package:task_manager/providers/category_provider.dart';
import 'package:task_manager/providers/todo_provider.dart';

class TodoPage extends StatefulWidget {
  TodoPage(this.title, this.todo);
  final String title;
  final Todo todo;

  @override
  _TodoPageState createState() => _TodoPageState(todo);
}

class _TodoPageState extends State<TodoPage> {
  _TodoPageState(this.todo);
  Todo todo;
  TodoProvider todoProvider;
  CategoryProvider categoryProvider;

  @override
  Widget build(BuildContext context) {
    MyDatabase databaseProvider = Provider.of<MyDatabase>(context);
    todoProvider = Provider.of<TodoProvider>(context);
    categoryProvider = Provider.of<CategoryProvider>(context);
    categoryProvider.injectDatabaseProvider(databaseProvider);

    todoProvider.injectDatabaseProvider(databaseProvider);
    todo = (todoProvider.todo != null && todoProvider.todo.id == todo.id)
        ? todoProvider.todo
        : todo;
    return new FutureBuilder(
      future: _updateCategory(categoryProvider),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          default:
            if (snapshot.hasError)
              return new Text('Error: ${snapshot.error}');
            else
              return Scaffold(
                appBar: buildAppBar(),
                body: SingleChildScrollView(
                    child: _buildTodoInfoSection(todoProvider, context)),
              );
        }
      },
    );
  }

  Future _updateCategory(CategoryProvider categoryProvider) async {
    return categoryProvider.updateCategory(todo.category);
  }

  Column _buildTodoInfoSection(
      TodoProvider todoProvider, BuildContext context) {
    return Column(
      children: <Widget>[
        Center(
          child: Text(
            todo.name,
            style: TextStyle(fontSize: 36),
          ),
        ),
        _buildCircleAvatar(todo),
        _buildCategoryText(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Center(
            child: Container(
              height: 300,
              child: buildDescriptionText(),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: buildTodoButtons(todoProvider, context),
        ),
      ],
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.greenAccent[700],
      title: Text(todo.name),
    );
  }

  List<Widget> buildTodoButtons(
      TodoProvider todoProvider, BuildContext context) {
    return <Widget>[
      IconButton(
        onPressed: () => {
          todoProvider.toggleDoneFlag(todo),
        },
        icon: Icon(Icons.done),
        color: todo.done ? Colors.green : Colors.indigo,
      ),
      IconButton(
          onPressed: () =>
              {todoProvider.removeTodo(todo.id), Navigator.pop(context)},
          icon: Icon(Icons.delete)),
    ];
  }

  Card buildDescriptionText() {
    final _textDescriptionController = TextEditingController();
    _textDescriptionController.text = todo.description;

    return Card(
      margin: EdgeInsets.all(30.0),
        color: Colors.green[100],
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: TextField(
            controller: _textDescriptionController,
            maxLines: 8,
            decoration:
                InputDecoration.collapsed(hintText: "Enter the description"),
            style: GoogleFonts.ibarraRealNova(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              textStyle: TextStyle(letterSpacing: .5),
            ),
          ),
        ));
  }

  Text _buildCategoryText() {
    return Text(
      todo.category.toString(),
      style: GoogleFonts.ibarraRealNova(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        textStyle: TextStyle(letterSpacing: .5),
      ),
    );
  }

  CircleAvatar _buildCircleAvatar(Todo todo) {
    //TODO: Check this, categoryProvider.category should never be null.
    String imgUrl = categoryProvider.category != null
        ? categoryProvider.category.imageUrl
        : '';
    return CircleAvatar(
      backgroundImage: NetworkImage(imgUrl),
      radius: 80,
    );
  }
}
