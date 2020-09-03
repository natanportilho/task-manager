import 'package:flutter/material.dart';
import 'package:task_manager/models/color_theme_model.dart';

class ThemeService {
  ColorTheme currentColorTheme;

  List<ColorTheme> createColorsList() {
    final List<ColorTheme> colors = <ColorTheme>[];

    ColorTheme red = ColorTheme();
    red.name = 'red';
    red.primaryColor = Colors.red;
    red.secondaryColor = Colors.redAccent[100];
    red.thirdColor = Colors.transparent;
    colors.add(red);

    ColorTheme green = ColorTheme();
    green.name = 'green';
    green.primaryColor = Colors.green;
    green.secondaryColor = Colors.greenAccent[100];
    green.thirdColor = Colors.transparent;
    colors.add(green);

    ColorTheme purple = ColorTheme();
    purple.name = 'purple';
    purple.primaryColor = Colors.purple;
    purple.secondaryColor = Colors.purpleAccent[100];
    purple.thirdColor = Colors.transparent;
    colors.add(purple);

    ColorTheme blue = ColorTheme();
    blue.name = 'blue';
    blue.primaryColor = Colors.blue;
    blue.secondaryColor = Colors.blue[100];
    blue.thirdColor = Colors.transparent;
    colors.add(blue);

    ColorTheme yellow = ColorTheme();
    yellow.name = 'yellow';
    yellow.primaryColor = Colors.yellow;
    yellow.secondaryColor = Colors.yellowAccent[100];
    yellow.thirdColor = Colors.transparent;
    colors.add(yellow);

    ColorTheme orange = ColorTheme();
    orange.name = 'orange';
    orange.primaryColor = Colors.orange;
    orange.secondaryColor = Colors.orangeAccent[100];
    orange.thirdColor = Colors.transparent;
    colors.add(orange);

    return colors;
  }
}
