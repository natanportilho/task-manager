import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/models/task_model.dart';
import 'package:task_manager/pages/select_category_page.dart';
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
  List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    taskStore = Provider.of<TaskStore>(context);
    return FutureBuilder(
      future: _updateCategory(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: buildAppBar(),
            body: SingleChildScrollView(
                child:
                    Observer(builder: (_) => _buildTodoInfoSection(context))),
            bottomNavigationBar: BottomAppBar(
              color: Colors.transparent,
              child: Observer(builder: (_) => _buildTodoButtons(context)),
              elevation: 0,
            ),
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

  Future _updateCategory() async {
    var completer = new Completer<String>();
    completer.complete("a");
    return completer.future;
  }

  Column _buildTodoInfoSection(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildCircleAvatar(todo),
        _buildCategoryText(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Center(
            child: Container(
              height: 200,
              child: buildDescriptionText(),
            ),
          ),
        ),
      ],
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text(todo.name),
    );
  }

  Row _buildTodoButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        IconButton(
          onPressed: () => {
            _toggleDoneFlag(todo),
          },
          icon: Icon(Icons.done),
          color: todo.done ? Colors.green : Colors.indigo,
        ),
        IconButton(
            onPressed: () => {taskStore.remove(todo), Navigator.pop(context)},
            icon: Icon(Icons.delete)),
      ],
    );
  }

  Card buildDescriptionText() {
    return Card(
        margin: EdgeInsets.all(20.0),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: TextFormField(
            initialValue: todo.description,
            textInputAction: TextInputAction.done,
            onChanged: (text) {
              taskStore.updateDescription(todo.id.documentID, text);
            },
            decoration:
                InputDecoration.collapsed(hintText: "Enter the description"),
          ),
        ));
  }

  Text _buildCategoryText() {
    return Text(
      "Place Holder Category",
      //todo.category.name.toString(),
      style: GoogleFonts.ibarraRealNova(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        textStyle: TextStyle(letterSpacing: .5),
      ),
    );
  }

  Padding _buildCircleAvatar(Task todo) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        child: _getCategoryImage(todo.category.imageUrl),
        onTap: () => {_goToSelectCategoryPage(todo)},
      ),
    );
  }

  Future _goToSelectCategoryPage(Task todo) {
    return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SelectCategoryPage(todo.id.documentID),
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
    taskStore.toggleTodo(task);
  }
}
