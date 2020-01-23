import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/persistence/color_theme.dart';

class ColorThemeProvider extends ChangeNotifier {
  ColorTheme color;

  Future setColor(ColorTheme color) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('color', color.name);
    this.color = color;
    notifyListeners();
  }
}
