import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/persistence/todo_table.dart';
import 'package:task_manager/providers/category_provider.dart';
import 'package:task_manager/providers/color_theme_provider.dart';

class CreateCategorySecondStepPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final String imgUrl;
  String name;
  CreateCategorySecondStepPage(this.imgUrl);

  @override
  Widget build(BuildContext context) {
    ColorThemeProvider colorThemeProvider =
        Provider.of<ColorThemeProvider>(context);

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: colorThemeProvider.color == null
            ? Colors.green
            : colorThemeProvider.color.primaryColor,
        title: Text('Create Category'),
      ),
      body: Material(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: AssetImage(this.imgUrl),
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
    final MyDatabase databaseProvider =
        Provider.of<MyDatabase>(context, listen: false);
    final CategoryProvider categoryProvider =
        Provider.of<CategoryProvider>(context, listen: false);
    categoryProvider.injectDatabaseProvider(databaseProvider);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _createNameField(),
          RaisedButton(
            onPressed: () {
              if (_formKey.currentState.validate()) {
                categoryProvider.addCategory(
                    Category(id: name, name: name, imageUrl: imgUrl));
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
