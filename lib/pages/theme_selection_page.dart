import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/persistence/color_theme.dart';
import 'package:task_manager/providers/color_theme_provider.dart';

class ThemeSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ColorThemeProvider colorThemeProvider =
        Provider.of<ColorThemeProvider>(context);

    final List<ColorTheme> colors = _createColorsList();

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Select A Beautiful Theme'),
      ),
      body: Material(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: GridView.count(
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
            )),
      ),
    ));
  }

  List<ColorTheme> _createColorsList() {
    final List<ColorTheme> colors = <ColorTheme>[];

    ColorTheme red = ColorTheme();
    red.name = 'red';
    red.primaryColor = Colors.red;
    red.secondaryColor = Colors.redAccent[300];
    red.thirdColor = Colors.redAccent[50];
    colors.add(red);

    ColorTheme green = ColorTheme();
    green.name = 'green';
    green.primaryColor = Colors.green;
    green.secondaryColor = Colors.greenAccent[300];
    green.thirdColor = Colors.greenAccent[50];
    colors.add(green);

    ColorTheme purple = ColorTheme();
    purple.name = 'purple';
    purple.primaryColor = Colors.purple;
    purple.secondaryColor = Colors.purpleAccent[300];
    purple.thirdColor = Colors.purpleAccent[50];
    colors.add(purple);

    ColorTheme blue = ColorTheme();
    blue.name = 'blue';
    blue.primaryColor = Colors.blue;
    blue.secondaryColor = Colors.blueAccent[300];
    blue.thirdColor = Colors.blueAccent[50];
    colors.add(blue);

    ColorTheme yellow = ColorTheme();
    yellow.name = 'yellow';
    yellow.primaryColor = Colors.yellow;
    yellow.secondaryColor = Colors.yellowAccent[300];
    yellow.thirdColor = Colors.yellowAccent[50];
    colors.add(yellow);

    ColorTheme orange = ColorTheme();
    orange.name = 'orange';
    orange.primaryColor = Colors.orange;
    orange.secondaryColor = Colors.orangeAccent[300];
    orange.thirdColor = Colors.orangeAccent[50];
    colors.add(orange);

    return colors;
  }
}
