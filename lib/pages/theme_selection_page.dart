import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/persistence/color_theme.dart';
import 'package:task_manager/providers/color_theme_provider.dart';

class ThemeSelectionPage extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    ColorThemeProvider colorThemeProvider = Provider.of<ColorThemeProvider>(context);
        Provider.of<ColorThemeProvider>(context);

    ColorTheme colorTheme = ColorTheme();
    final List<ColorTheme> colors = colorTheme.createColorsList();

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
      backgroundColor: colorThemeProvider.color == null ? Colors.green : colorThemeProvider.color.primaryColor,
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

  // List<ColorTheme> _createColorsList() {
  //   final List<ColorTheme> colors = <ColorTheme>[];

  //   ColorTheme red = ColorTheme();
  //   red.name = 'red';
  //   red.primaryColor = Colors.red;
  //   red.secondaryColor = Colors.redAccent[100];
  //   red.thirdColor = Colors.transparent;
  //   colors.add(red);

  //   ColorTheme green = ColorTheme();
  //   green.name = 'green';
  //   green.primaryColor = Colors.green;
  //   green.secondaryColor = Colors.greenAccent[100];
  //   green.thirdColor = Colors.transparent;
  //   colors.add(green);

  //   ColorTheme purple = ColorTheme();
  //   purple.name = 'purple';
  //   purple.primaryColor = Colors.purple;
  //   purple.secondaryColor = Colors.purpleAccent[100];
  //   purple.thirdColor = Colors.transparent;
  //   colors.add(purple);

  //   ColorTheme blue = ColorTheme();
  //   blue.name = 'blue';
  //   blue.primaryColor = Colors.blue;
  //   blue.secondaryColor = Colors.blue[100];
  //   blue.thirdColor = Colors.transparent;
  //   colors.add(blue);

  //   ColorTheme yellow = ColorTheme();
  //   yellow.name = 'yellow';
  //   yellow.primaryColor = Colors.yellow;
  //   yellow.secondaryColor = Colors.yellowAccent[100];
  //   yellow.thirdColor = Colors.transparent;
  //   colors.add(yellow);

  //   ColorTheme orange = ColorTheme();
  //   orange.name = 'orange';
  //   orange.primaryColor = Colors.orange;
  //   orange.secondaryColor = Colors.orangeAccent[100];
  //   orange.thirdColor = Colors.transparent;
  //   colors.add(orange);

  //   return colors;
  // }
}
