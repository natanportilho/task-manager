import 'package:cloud_firestore/cloud_firestore.dart';


//todo: Why there is a Task model and a Todo model?
class TodoModel {
  final DocumentReference id;
  String name;
  String description;
  bool done;

  TodoModel({this.id,this.name, this.description, this.done});

  factory TodoModel.fromDocument(DocumentSnapshot doc){
    return TodoModel(name: doc['name'], description: doc['description'], done: doc['done'], id: doc.reference);
  }
}
