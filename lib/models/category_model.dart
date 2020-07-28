import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';
part 'category_model.g.dart';

class Category = _Category with _$Category;

abstract class _Category with Store {
  @observable
  DocumentReference id;
  @observable
  String name;
  @observable
  String imageUrl;

  _Category({this.id, this.name, this.imageUrl});

  _Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['imageUrl'] = this.imageUrl;
    return data;
  }

  factory _Category.fromDocument(DocumentSnapshot doc) {
    return Category(
        name: doc['name'], imageUrl: doc['imageUrl'], id: doc.reference);
  }
}
