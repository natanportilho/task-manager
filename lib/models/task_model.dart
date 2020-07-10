import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';
import 'package:task_manager/models/category_model.dart';
part 'task_model.g.dart';

class Task = _Task with _$Task;

abstract class _Task with Store {
  @observable
  DocumentReference id;
  @observable
  String name;
  @observable
  String description;
  @observable
  bool done;
  @observable
  Category category;

  _Task({this.id, this.name, this.description, this.done, this.category});

  // _Task.fromJson(Map<String, dynamic> json) {
  //   id = json['id'];
  //   name = json['name'];
  //   description = json['description'];
  //   done = json['done'];
  //   category = json['category'] != null
  //       ? new Category.fromJson(json['category'])
  //       : null;
  // }

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

  factory _Task.fromDocument(DocumentSnapshot doc) {
    return Task(
        name: doc['name'],
        description: doc['description'],
        done: doc['done'],
        id: doc.reference);
  }
}
