import 'package:flutter/material.dart';

class CreateCategoryPage extends StatelessWidget {
  const CreateCategoryPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent[700],
        title: Text('Create todo'),
      ),
      body: Material(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text('Oi'),
        ),
      ),
    ));
  }
}
