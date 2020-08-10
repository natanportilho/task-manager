import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_manager/models/category_model.dart';
import 'package:task_manager/models/task_model.dart';
import 'package:task_manager/repositories/todo_repository_interface.dart';

class TodoRepository implements ITodoRepository {
  Firestore firestore;
  CollectionReference _userReference;
  // FirebaseDatabase _database = FirebaseDatabase.instance;

  @override
  Stream<List<Task>> getTodos() {
    this.firestore = Firestore.instance;
    return this.firestore.collection('task').snapshots().map((query) {
      return query.documents.map((doc) {
        return fromDocument(doc);
      }).toList();
    });
  }

  Future<DocumentReference> addTodo(Task task) {
    this.firestore = Firestore.instance;
    return this.firestore.collection('task').add(task.toJson());
  }

  Future<DocumentReference> toggleTodo(Task task) {
    this.firestore = Firestore.instance;

    task.done = !task.done;
    if (task != null) {
      this
          .firestore
          .collection("task")
          .document(task.id.documentID)
          .updateData({'done': task.done});
    }
  }

    Future<DocumentReference> updateDescription(Task task) {
    this.firestore = Firestore.instance;

    if (task != null) {
      this
          .firestore
          .collection("task")
          .document(task.id.documentID)
          .updateData({'description': task.description});
    }
  }

// Why cant i have this in the model?
  Task fromDocument(DocumentSnapshot doc) {
    //printDoc(doc['category']);

    return Task(
        name: doc['name'],
        description: doc['description'],
        done: doc['done'],
        id: doc.reference,
        category: categoryFromDocument(doc['category'])
        );
  }

  // Why cant i have this in the model?
  Category categoryFromDocument(Map<String, dynamic> doc) {
    return Category(
        name: doc['name'], imageUrl: doc['imageUrl'], id: doc["id"]);
  }

}
