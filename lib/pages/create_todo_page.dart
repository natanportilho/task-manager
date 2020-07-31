
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

    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: buildAppBar(),
      body: buildBody(context),
      bottomNavigationBar: buildBottomAppBar(),
    ));
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text('Create todo'),
    );
  }

  Material buildBody(BuildContext context) {
    return Material(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: _createTodoForm(context)),
    );
  }

  BottomAppBar buildBottomAppBar() {
    return BottomAppBar(
      color: Colors.transparent,
      child: _createSubmitButton(),
    );
  }

  Form _createTodoForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                'Category:    ',
                style: TextStyle(fontSize: 16.0),
              ),
              Observer(builder: (_) => _createDropDown()),
              IconButton(
                icon: Icon(Icons.add),
                color: Colors.purpleAccent[700],
                onPressed: () => {_goToCreateCategoryPage(context)},
              )
            ],
          ),
          _createNameField(),
          _createDescriptionField()
        ],
      ),
    );
  }

  TextFormField _createDescriptionField() {
    return TextFormField(
      decoration: const InputDecoration(
        hintText: 'Description',
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter a description'; //TODO: Description sometimes can be null
        }
        description = value;
        return null;
      },
    );
  }

  TextFormField _createNameField() {
    return TextFormField(
      decoration: const InputDecoration(
        hintText: 'Name',
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter a name';
        }
        name = value;
        return null;
      },
    );
  }

  Future _goToCreateCategoryPage(BuildContext context) {
    return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CreateCategoryPage(),
        ));
  }

  DropdownButton _createDropDown() {
    return DropdownButton<String>(
      items: _createCategoriesList().toList(),
      onChanged: (newValue) {
        category = newValue;
        updateCategoryName(newValue);
      },
      underline: Container(
        height: 2,
        color: Colors.green,
      ),
      icon: Icon(Icons.arrow_downward),
      value: category != null ? category : "Personal",
    );
  }

  List<DropdownMenuItem<String>> _createCategoriesList() {
    List<DropdownMenuItem<String>> categoriesNames =
        List<DropdownMenuItem<String>>();
        //todo: fix this, we need to get categories from firebase now
    if (categoryStore.categories != null) {
      categoryStore.categories.forEach((c) => {
            categoriesNames.add(DropdownMenuItem<String>(
              value: c.name,
              child: Text(
                c.name,
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

  Padding _createSubmitButton() {
    TaskStore taskStore = Provider.of<TaskStore>(context);

    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: RaisedButton(
          onPressed: () {
            if (_formKey.currentState.validate()) {
              Category c = categoryStore.getCategoryByName(category);
              taskStore.add(Task(
                  category: c,
                  name: name,
                  description: description,
                  done: false));
              Navigator.pop(context);
            }
          },
          child: Text('Submit'),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
              side: BorderSide(color: Colors.white, width: 0)),
          padding: const EdgeInsets.symmetric(vertical: 16.0),
        ));
  }
}
