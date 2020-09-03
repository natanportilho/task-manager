import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/models/color_theme_model.dart';
import 'package:task_manager/services/theme_service.dart';

class ThemeSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeService themeService = ThemeService();
    final List<ColorTheme> colors = themeService.createColorsList();

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Select A Beautiful Theme'),
      ),
      body: Material(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: _buildColourGrid(colors, context)),
      ),
    ));
  }

  GridView _buildColourGrid(List<ColorTheme> colors, BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: List.generate(6, (index) {
        return Center(
          child: GestureDetector(
            onTap: () => {
              _changeColor(context, colors[index]),
              Navigator.pop(context),
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 300,
                color: colors[index].primaryColor,
              ),
            ),
          ),
        );
      }),
    );
  }

  Future<void> _changeColor(BuildContext context, ColorTheme colorTheme) async {
    DynamicTheme.of(context).setThemeData(new ThemeData(
        primaryColor: colorTheme.primaryColor,
        accentColor: colorTheme.secondaryColor));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme', colorTheme.name);
  }
}
