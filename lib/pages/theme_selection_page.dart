import 'package:flutter/material.dart';

class ThemeSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<MaterialColor> colors = _createColorsList();

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent[700],
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
                    onTap: () => {},
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 300,
                        color: colors[index],
                      ),
                    ),
                  ),
                );
              }),
            )
            // padding: const EdgeInsets.symmetric(horizontal: 16.0),
            // child: ListView(
            //   padding: const EdgeInsets.all(8),
            //   children: <Widget>[
            //     Container(
            //       height: 160,
            //       color: Colors.red,
            //     ),
            //     Container(
            //       height: 160,
            //       color: Colors.blue,
            //     ),
            //     Container(
            //       height: 160,
            //       color: Colors.green,
            //     ),
            //     Container(
            //       height: 160,
            //       color: Colors.yellow,
            //     ),
            //     Container(
            //       height: 160,
            //       color: Colors.orange,
            //     ),
            //   ],
            // ),
            // child: ListView(
            //   // This next line does the trick.
            //   scrollDirection: Axis.horizontal,
            //   children: <Widget>[
            //     Container(
            //       width: 160.0,
            //       color: Colors.red,
            //     ),
            //     Container(
            //       width: 160.0,
            //       color: Colors.blue,
            //     ),
            //     Container(
            //       width: 160.0,
            //       color: Colors.green,
            //     ),
            //     Container(
            //       width: 160.0,
            //       color: Colors.yellow,
            //     ),
            //     Container(
            //       width: 160.0,
            //       color: Colors.orange,
            //     ),
            //   ],
            // )
            ),
      ),
    ));
  }

  List<MaterialColor> _createColorsList() {
    final List<MaterialColor> colors = <MaterialColor>[];
    colors.add(Colors.red);
    colors.add(Colors.green);
    colors.add(Colors.blue);
    colors.add(Colors.purple);
    colors.add(Colors.yellow);
    colors.add(Colors.orange);
    return colors;
  }
}
