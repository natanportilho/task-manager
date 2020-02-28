import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/persistence/color_theme.dart';
import 'package:task_manager/providers/color_theme_provider.dart';

class ThemeSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ColorThemeProvider colorThemeProvider =
        Provider.of<ColorThemeProvider>(context);
    Provider.of<ColorThemeProvider>(context);

    ColorTheme colorTheme = ColorTheme();
    final List<ColorTheme> colors = colorTheme.createColorsList();

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: colorThemeProvider.color == null
            ? Colors.green
            : colorThemeProvider.color.primaryColor,
        title: Text('Select A Beautiful Theme'),
      ),
      body: Material(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: _buildColourGrid(colorThemeProvider, colors, context)),
      ),
    ));
  }

  GridView _buildColourGrid(ColorThemeProvider colorThemeProvider,
      List<ColorTheme> colors, BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: List.generate(6, (index) {
        return Center(
          child: GestureDetector(
            onTap: () => {
              colorThemeProvider.setColor(colors[index]),
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
}
