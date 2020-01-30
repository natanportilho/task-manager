import 'package:flutter/material.dart';

import 'create_category_second_step_page.dart';

class CreateCategoryPage extends StatelessWidget {
  const CreateCategoryPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> urlImages = _createImagesList();

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Create Category'),
      ),
      body: Material(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: GridView.count(
              crossAxisCount: 4,
              children: List.generate(urlImages.length, (index) {
                return Center(
                  child: GestureDetector(
                    onTap: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateCategorySecondStepPage(urlImages[index]),
                          ))
                    },
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(urlImages[index]),
                      maxRadius: 40,
                    ),
                  ),
                );
              }),
            )),
      ),
    ));
  }

  List<String> _createImagesList() {
    final List<String> urlImages = <String>[];
    urlImages.add(
        'https://images.unsplash.com/photo-1521412644187-c49fa049e84d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60');
    urlImages.add(
        'https://images.unsplash.com/photo-1553374280-11356158085c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60');
    urlImages.add(
        'https://images.unsplash.com/photo-1566579090262-51cde5ebe92e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60');
    urlImages.add(
        'https://images.unsplash.com/photo-1571008887538-b36bb32f4571?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80');
    urlImages.add(
        'https://images.unsplash.com/photo-1494498902093-87f291949d17?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60');
    urlImages.add(
        'https://images.unsplash.com/photo-1537202108838-e7072bad1927?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=685&q=80');
    urlImages.add(
        'https://images.unsplash.com/photo-1462926703708-44ab9e271d97?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=564&q=80');
    urlImages.add(
        'https://images.unsplash.com/photo-1494887205043-c5f291293cf6?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80');
    urlImages.add(
        'https://images.unsplash.com/photo-1495954484750-af469f2f9be5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60');
    urlImages.add(
        'https://images.unsplash.com/photo-1531594896955-305cf81269f1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60');
    urlImages.add(
        'https://images.unsplash.com/photo-1521931961826-fe48677230a5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60');
    urlImages.add(
        'https://images.unsplash.com/photo-1436076863939-06870fe779c2?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60');

    return urlImages;
  }
}
