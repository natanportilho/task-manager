import 'package:flutter/material.dart';

class CreateCategorySecondStepPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final String imgUrl;
  String name;
  CreateCategorySecondStepPage(this.imgUrl);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent[700],
        title: Text('Create Category'),
      ),
      body: Material(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: NetworkImage(this.imgUrl),
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
