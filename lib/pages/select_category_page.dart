import 'package:flutter/material.dart';

class SelectCategoryPage extends StatelessWidget {
  final int todoId;
  String name;
  SelectCategoryPage(this.todoId);

  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Select Category'),
      ),
      body: Material(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: GridView.count(
              crossAxisCount: 4,
              children:
                  List.generate(10, (index) {
                return Center(
                  child: GestureDetector(
                    onTap: () => {
                    },
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          'categoryProvider.categories[index].imageUrl'),
                      maxRadius: 40,
                    ),
                  ),
                );
              }),
            )),
      ),
    ));
  }
}