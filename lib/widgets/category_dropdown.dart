import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/persistence/todo_table.dart';
import 'package:task_manager/providers/category_dropdown_provider.dart';
import 'package:task_manager/providers/category_provider.dart';

class CategoryDropdown extends StatefulWidget {
  CategoryDropdown({Key key}) : super(key: key);

  @override
  _CategoryDropdownState createState() => _CategoryDropdownState();
}

class _CategoryDropdownState extends State<CategoryDropdown> {
  String dropdownValue = 'Personal';
  CategoryProvider categoryProvider;

  @override
  Widget build(BuildContext context) {
    final CategoryDropdownProvider categoryDropdownProvider =
        Provider.of<CategoryDropdownProvider>(context);
    final MyDatabase databaseProvider = Provider.of<MyDatabase>(context);
    categoryProvider = Provider.of<CategoryProvider>(context);
    categoryProvider.injectDatabaseProvider(databaseProvider);

    return buildDropdownButton(categoryDropdownProvider);
  }

  DropdownButton<String> buildDropdownButton(
      CategoryDropdownProvider categoryDropdownProvider) {
    return DropdownButton<String>(
      value: categoryDropdownProvider.category,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.greenAccent[700],
      ),
      onChanged: (String newValue) {
        categoryDropdownProvider.updateCategory(newValue);
      },
      items: <String>['Personal', 'Work', 'Study']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
