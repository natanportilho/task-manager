import 'package:flutter/material.dart';

class CreateCategorySecondStepPage extends StatelessWidget {
  final String imgUrl;
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
          child: CircleAvatar(
            backgroundImage: NetworkImage(this.imgUrl),
            radius: 80,
          ),
        ),
      ),
    ));
  }
}
