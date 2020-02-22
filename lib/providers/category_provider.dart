import 'package:flutter/material.dart';
import 'package:task_manager/persistence/todo_table.dart';

class CategoryProvider extends ChangeNotifier {
  List<Category> categories;
  Category category;

  MyDatabase _databaseProvider;

  void injectDatabaseProvider(MyDatabase databaseProvider) async {
    this._databaseProvider = databaseProvider;
    categories = await _databaseProvider.getAllCategories();
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
    return result[0];
  }

  Future<void> addCategory(Category category) async {
    await this._databaseProvider.addCategory(category);
     categories = await _databaseProvider.getAllCategories();
     notifyListeners();
  }
}
