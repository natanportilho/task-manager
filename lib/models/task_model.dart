import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';
import 'package:task_manager/models/category_model.dart';
part 'task_model.g.dart';

class Task = _Task with _$Task;

abstract class _Task with Store {
  @observable
  DocumentReference id;
  @observable
  String description;
  @observable
  bool done;
  @observable
  Category category;
  @observable
  bool important;

  _Task({this.id, this.description, this.done, this.category, this.important});

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
    data['description'] = this.description;
    data['done'] = this.done;
    data['important'] = this.important;
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    return data;
  }

  // factory _Task.fromDocument(DocumentSnapshot doc) {
  //   return Task(
  //       description: doc['description'],
  //       done: doc['done'],
  //       id: doc.reference,
  //       important: doc['important']);
  // }
}
