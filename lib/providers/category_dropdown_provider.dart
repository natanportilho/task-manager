import 'package:flutter/material.dart';

class CategoryDropdownProvider extends ChangeNotifier {
  String category = 'Personal';

  updateCategory(String category) {
    this.category = category;
    notifyListeners();
  }
}
