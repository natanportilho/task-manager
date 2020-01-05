import 'package:flutter/material.dart';
import 'package:task_manager/persistence/todo_table.dart';

class CategoryProvider extends ChangeNotifier {
  List<Category> categories;
  Category category;

  MyDatabase _databaseProvider;

  void injectDatabaseProvider(MyDatabase databaseProvider) {
    this._databaseProvider = databaseProvider;
    _databaseProvider.getAllCategories().then((result) => {
          categories = result,
        });
  }

  Future<Category> getCategoryById(String id) async {
    Category category;
    List<Category> result = await this._databaseProvider.getCategoryById(id);
    category = result[0];
    return category;
  }

  Future updateCategory(String categoryId) async {
    List<Category> result =
        await this._databaseProvider.getCategoryById(categoryId);
    this.category = result[0];
    notifyListeners();
  }
}
