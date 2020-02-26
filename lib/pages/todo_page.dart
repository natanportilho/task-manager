import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/pages/select_category_page.dart';
import 'package:task_manager/persistence/todo_table.dart';
import 'package:task_manager/providers/category_provider.dart';
import 'package:task_manager/providers/color_theme_provider.dart';
import 'package:task_manager/providers/todo_provider.dart';

class TodoPage extends StatefulWidget {
  TodoPage(this.title, this.todo);
  final String title;
  final Todo todo;

  @override
  _TodoPageState createState() => _TodoPageState(todo);
}

class _TodoPageState extends State<TodoPage> {
  final _textDescriptionController = TextEditingController();
  _TodoPageState(this.todo);
  Todo todo;
  TodoProvider todoProvider;
  CategoryProvider categoryProvider;
  ColorThemeProvider colorThemeProvider;

  @override
  Widget build(BuildContext context) {
    colorThemeProvider = Provider.of<ColorThemeProvider>(context);
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
        if (snapshot.hasData) {
          return Scaffold(
            appBar: buildAppBar(),
            body: SingleChildScrollView(
                child: _buildTodoInfoSection(todoProvider, context)),
          );
        } else if (snapshot.hasError) {
          return new Text('Error: ${snapshot.error}');
        }
        return Scaffold(
          appBar: buildAppBar(),
          body: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 100.0),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                ],
              ),
            ],
          ),
        );
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
        Container(
            child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: buildTodoButtons(todoProvider, context),
                  ),
                ))),
      ],
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: colorThemeProvider.color == null
          ? Colors.green
          : colorThemeProvider.color.primaryColor,
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
    _textDescriptionController.text = todo.description;

    return Card(
        margin: EdgeInsets.all(20.0),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: TextField(
            textInputAction: TextInputAction.done,
            onEditingComplete: () {
              todoProvider.updateTodoDescription(
                  todo.id, _textDescriptionController.text);
              FocusScope.of(context).requestFocus(new FocusNode());
            },
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

  Padding _buildCircleAvatar(Todo todo) {
    //TODO: Check this, categoryProvider.category should never be null.
    String imgUrl = categoryProvider.category != null
        ? categoryProvider.category.imageUrl
        : '';
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        child: _getCategoryImage(imgUrl),
        onTap: () => {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SelectCategoryPage(todo.id),
              ))
        },
      ),
    );
  }

  CircleAvatar _getCategoryImage(String imageUrl) {
    if (imageUrl == '') {
      return CircleAvatar(
        backgroundColor: Colors.black26,
        child: Text('Loading'),
        radius: 50,
      );
    } else {
      return CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
        radius: 50,
      );
    }
  }
}
