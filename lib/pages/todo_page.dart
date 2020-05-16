import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/models/task_model.dart';
import 'package:task_manager/pages/select_category_page.dart';
import 'package:task_manager/persistence/todo_table.dart';
import 'package:task_manager/providers/category_provider.dart';
import 'package:task_manager/providers/todo_provider.dart';
import 'package:task_manager/stores/task_store.dart';

class TodoPage extends StatefulWidget {
  TodoPage(this.title, this.todo);
  final String title;
  final Task todo;

  @override
  _TodoPageState createState() => _TodoPageState(todo);
}

class _TodoPageState extends State<TodoPage> {
  TaskStore taskStore;
  _TodoPageState(this.todo);
  Task todo;
  TodoProvider todoProvider;
  CategoryProvider categoryProvider;

  @override
  Widget build(BuildContext context) {
    taskStore = Provider.of<TaskStore>(context);
    initProviders(context);
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
          body: _buildSpinnerScreen(),
        );
      },
    );
  }

  _buildSpinnerScreen() {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 100.0),
              child: Center(
                  child: CircularProgressIndicator(
                      backgroundColor: Colors.indigo,
                      valueColor: new AlwaysStoppedAnimation<Color>(
                          Colors.indigoAccent))),
            ),
          ],
        ),
      ],
    );
  }

  void initProviders(BuildContext context) {
    MyDatabase databaseProvider = Provider.of<MyDatabase>(context);
    todoProvider = Provider.of<TodoProvider>(context);
    categoryProvider = Provider.of<CategoryProvider>(context);
    categoryProvider.injectDatabaseProvider(databaseProvider);
    todoProvider.injectDatabaseProvider(databaseProvider);
    todo = (todoProvider.todo != null && todoProvider.todo.id == todo.id)
        ? todoProvider.todo
        : todo;
  }

  Future _updateCategory(CategoryProvider categoryProvider) async {
    return categoryProvider.updateCategory(todo.category.name);
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
                    children: buildTodoButtons(context),
                  ),
                ))),
      ],
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text(todo.name),
    );
  }

  List<Widget> buildTodoButtons(BuildContext context) {
    return <Widget>[
      Observer(
        builder: (_) => IconButton(
          onPressed: () => {
            print(todo.done),
            _toggleDoneFlag(todo),
          },
          icon: Icon(Icons.done),
          color: todo.done ? Colors.green : Colors.indigo,
        ),
      ),
      IconButton(
          onPressed: () => {taskStore.remove(todo), Navigator.pop(context)},
          icon: Icon(Icons.delete)),
    ];
  }

// Observer(
//         builder: (_) => _buildListView(taskStore.tasks),
//       )
  Card buildDescriptionText() {
    return Card(
        margin: EdgeInsets.all(20.0),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: TextFormField(
            initialValue: todo.description,
            textInputAction: TextInputAction.done,
            onChanged: (text) {
              taskStore.updateDescription(todo.id, text);
            },
            decoration:
                InputDecoration.collapsed(hintText: "Enter the description"),
          ),
        ));
  }

  Text _buildCategoryText() {
    return Text(
      todo.category.name.toString(),
      style: GoogleFonts.ibarraRealNova(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        textStyle: TextStyle(letterSpacing: .5),
      ),
    );
  }

  Padding _buildCircleAvatar(Task todo) {
    //TODO: Check this, categoryProvider.category should never be null.
    String imgUrl = categoryProvider.category != null
        ? categoryProvider.category.imageUrl
        : '';
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        child: _getCategoryImage(imgUrl),
        onTap: () => {_goToSelectCategoryPage(todo)},
      ),
    );
  }

  Future _goToSelectCategoryPage(Task todo) {
    return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SelectCategoryPage(todo.id),
        ));
  }

  CircleAvatar _getCategoryImage(String imageUrl) {
    if (imageUrl == '')
      return _buildPlaceholderCategoryImage();
    else
      return _buildCategoryImage(imageUrl);
  }

  CircleAvatar _buildCategoryImage(String imageUrl) {
    return CircleAvatar(
      backgroundImage: NetworkImage(imageUrl),
      radius: 50,
    );
  }

  CircleAvatar _buildPlaceholderCategoryImage() {
    return CircleAvatar(
      backgroundColor: Colors.black26,
      child: Text('Loading'),
      radius: 50,
    );
  }

  _toggleDoneFlag(Task task) {
    taskStore.toggleDoneFlag(task.id);
  }
}
