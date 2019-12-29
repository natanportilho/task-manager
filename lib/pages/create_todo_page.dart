import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/providers/todo_provider.dart';

class CreateTodoPage extends StatefulWidget {
  CreateTodoPage({Key key}) : super(key: key);

  @override
  _CreateTodoPageState createState() => _CreateTodoPageState();
}

class _CreateTodoPageState extends State<CreateTodoPage> {
  final _formKey = GlobalKey<FormState>();

  String category;
  String name;
  String description;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(''),
        ),
        body: Material(
          child: _createTodoForm(context),
        ),
      ),
    );
  }

  Form _createTodoForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _createCateforyField(),
          _createNameField(),
          _createDescriptionField(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  final TodoProvider todoProvider =
                      Provider.of<TodoProvider>(context, listen: false);
                  todoProvider.addTodo(category, name, description);
                  Navigator.pop(context);
                }
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }

  TextFormField _createDescriptionField() {
    return TextFormField(
      decoration: const InputDecoration(
        hintText: 'Description',
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter a description'; //TODO: Description sometimes can be null
        }
        description = value;
        return null;
      },
    );
  }

  TextFormField _createNameField() {
    return TextFormField(
      decoration: const InputDecoration(
        hintText: 'Name',
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter a name';
        }
        name = value;
        return null;
      },
    );
  }

  TextFormField _createCateforyField() {
    return TextFormField(
      decoration: const InputDecoration(
        hintText: 'Category',
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter a category';
        }
        category = value;
        return null;
      },
    );
  }
}
