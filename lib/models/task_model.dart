import 'package:task_manager/models/category_model.dart';

class Task {
  int id;
  String name;
  String description;
  bool done;
  Category category;

  Task({this.id, this.name, this.description, this.done, this.category});

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    done = json['done'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['done'] = this.done;
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    return data;
  }
}
