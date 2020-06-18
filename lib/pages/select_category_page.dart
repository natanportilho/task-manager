import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/persistence/todo_table.dart';
import 'package:task_manager/providers/todo_provider.dart';

class SelectCategoryPage extends StatelessWidget {
  final int todoId;
  String name;
  SelectCategoryPage(this.todoId);
  TodoProvider todoProvider;

  @override
  Widget build(BuildContext context) {
    MyDatabase databaseProvider = Provider.of<MyDatabase>(context);
    todoProvider = Provider.of<TodoProvider>(context);

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
                      todoProvider.updateTodoCategory(
                          todoId, 'categoryProvider.categories[index].id'),
                      Navigator.pop(context)
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
