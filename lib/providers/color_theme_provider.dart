import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/persistence/color_theme.dart';

class ColorThemeProvider extends ChangeNotifier {
  ColorTheme color;

  Future init() async {
    final prefs = await SharedPreferences.getInstance();
    String colorName = prefs.getString('color');

    List<ColorTheme> colors = ColorTheme().createColorsList();
    ColorTheme colorTheme = ColorTheme();

    colors.forEach((c) => {
          if (c.name == colorName)
            {
              colorTheme = c,
            }
        });

    this.color = colorTheme;
    notifyListeners();
  }

  Future setColor(ColorTheme color) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('color', color.name);
    this.color = color;
    notifyListeners();
  }
}
