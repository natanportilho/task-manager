import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/stores/store_category.dart';
import 'package:task_manager/stores/task_store.dart';
import 'package:task_manager/models/task_model.dart';
import 'package:task_manager/models/category_model.dart';
import 'category_creation/create_category_first_step_page.dart';

class CreateTodoPage extends StatefulWidget {
  CreateTodoPage({Key key}) : super(key: key);

  @override
  _CreateTodoPageState createState() => _CreateTodoPageState();
}

class _CreateTodoPageState extends State<CreateTodoPage> {
  CategoryStore categoryStore;
  final _formKey = GlobalKey<FormState>();
  String category = "Personal";
  String name;
  String description;

  @override
  Widget build(BuildContext context) {
    categoryStore = Provider.of<CategoryStore>(context);

    return new WillPopScope(
      onWillPop: _onWillPop,
      child: SafeArea(
          child: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: buildAppBar(),
        body: buildBody(context),
      )),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      actions: <Widget>[
        Observer(
            builder: (_) => ButtonTheme(
                  child: _createDropDown(),
                  alignedDropdown: true,
                )),
        IconButton(
          icon: Icon(
            Icons.settings,
            color: Colors.white,
          ),
          onPressed: () {
            //todo: do something
          },
        )
      ],
    );
  }

  Material buildBody(BuildContext context) {
    return Material(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: _createTodoForm(context)),
    );
  }

  Form _createTodoForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[_createDescriptionField()],
      ),
    );
  }

  _createDescriptionField() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Container(
        height: 300,
        child: Form(
          autovalidate: true,
          child: TextFormField(
            autofocus: true,
            validator: (value) {
              if (value.isEmpty) {
                print(value);
                return 'Please enter a description';
              } else {
                print(value);
              }
              description = value;
              return null;
            },
            maxLines: 100,
            decoration: InputDecoration(
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.white,
              labelStyle: TextStyle(fontSize: 15.0),
              //hintText: 'Description',
            ),
          ),
        ),
      ),
    );
  }

  Future _goToCreateCategoryPage(BuildContext context) {
    return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CreateCategoryPage(),
        ));
  }

  DropdownButtonHideUnderline _createDropDown() {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
          items: _createCategoriesList().toList(),
          onChanged: (newValue) {
            if (newValue == "Add new...") {
              _goToCreateCategoryPage(context);
            } else {
              category = newValue;
              updateCategoryName(newValue);
            }
          },
          icon: Icon(
            Icons.arrow_drop_down,
            color: Colors.white,
          ),
          value: category != null ? category : "Personal",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none)),
    );
  }

  List<DropdownMenuItem<String>> _createCategoriesList() {
    List<DropdownMenuItem<String>> categoriesNames =
        List<DropdownMenuItem<String>>();
    categoriesNames.add(DropdownMenuItem<String>(
      value: "Add new...",
      child: Icon(Icons.add),
    ));
    if (categoryStore.categories != null &&
        categoryStore.categories.data != null) {
      categoryStore.categories.data.forEach((c) => {
            categoriesNames.add(DropdownMenuItem<String>(
              value: c.name,
              child: Text(
                c.name,
                textAlign: TextAlign.center,
                style: new TextStyle(
                  fontSize: 12.0,
                  decoration: TextDecoration.none,
                ),
              ),
            )),
          });
    }
    return categoriesNames;
  }

  void updateCategoryName(String categoryName) {
    setState(() {
      category = categoryName;
    });
  }

  Future<bool> _onWillPop() async {
    TaskStore taskStore = Provider.of<TaskStore>(context, listen: false);

    if (description != null && description.isNotEmpty) {
      Category c = categoryStore.getCategoryByName(category);
      taskStore.add(Task(category: c, description: description, done: false));
      Navigator.pop(context);
    } else {
      Navigator.pop(context);
    }
  }
}
