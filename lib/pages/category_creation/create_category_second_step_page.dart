import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/models/category_model.dart';
import 'package:task_manager/stores/store_category.dart';

class CreateCategorySecondStepPage extends StatefulWidget {
  final String imgUrl;

  CreateCategorySecondStepPage(this.imgUrl);

  @override
  _CreateCategorySecondStepPageState createState() => _CreateCategorySecondStepPageState();
}

class _CreateCategorySecondStepPageState extends State<CreateCategorySecondStepPage> {
  CategoryStore categoryStore;

  final _formKey = GlobalKey<FormState>();

  String name;

  @override
  Widget build(BuildContext context) {
    categoryStore = Provider.of<CategoryStore>(context);

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Create Category'),
      ),
      body: Material(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: NetworkImage(this.widget.imgUrl),
                  radius: 80,
                ),
                _createTodoForm(context)
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Form _createTodoForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _createNameField(),
          RaisedButton(
            onPressed: () {
              if (_formKey.currentState.validate()) {
                var rng = new Random();
                categoryStore.add(Category(id: rng.nextInt(100), name: name));
                Navigator.pop(context);
                Navigator.pop(context);
              }
            },
            child: Text('Create Category'),
          ),
        ],
      ),
    );
  }

  TextFormField _createNameField() {
    return TextFormField(
      decoration: const InputDecoration(
        hintText: 'Name',
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter a name for the category';
        }
        name = value;
        return null;
      },
    );
  }
}
