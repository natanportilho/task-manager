import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/providers/color_theme_provider.dart';

import 'create_category_second_step_page.dart';

class CreateCategoryPage extends StatelessWidget {
  const CreateCategoryPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> urlImages = _createImagesList();
    ColorThemeProvider colorThemeProvider =
        Provider.of<ColorThemeProvider>(context);

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: colorThemeProvider.color == null
            ? Colors.green
            : colorThemeProvider.color.primaryColor,
        title: Text('Create Category'),
      ),
      body: Material(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: _buildCategoryGridView(urlImages, context)),
      ),
    ));
  }

  GridView _buildCategoryGridView(
      List<String> urlImages, BuildContext context) {
    return GridView.count(
      crossAxisCount: 4,
      children: List.generate(urlImages.length, (index) {
        return Center(
          child: GestureDetector(
            onTap: () =>
                {_goToCreateCategorySecondStepPage(context, urlImages, index)},
            child: CircleAvatar(
              // backgroundImage: AssetImage(urlImages[index]),
              child: Image.asset('source/images/beer.jpg'),
              maxRadius: 40,
            ),
          ),
        );
      }),
    );
  }

  Future _goToCreateCategorySecondStepPage(
      BuildContext context, List<String> urlImages, int index) {
    return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CreateCategorySecondStepPage(urlImages[index]),
        ));
  }

  List<String> _createImagesList() {
    final List<String> urlImages = <String>[];
    urlImages.add('source/images/american_football.jpg');
    urlImages.add('images/basktball.jpg');
    urlImages.add('images/beach.jpg');
    urlImages.add('source/images/beer.jpg');
    urlImages.add('images/football.jpg');
    urlImages.add('images/laptop.jpg');
    urlImages.add('images/library.jpg');
    urlImages.add('images/life_freedom.jpg');
    urlImages.add('images/money.jpg');
    urlImages.add('images/phone.jpg');
    urlImages.add('/running.jpg');
    urlImages.add('video_game.jpg');
    return urlImages;
  }
}
