import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_manager/models/category_model.dart';
import 'package:task_manager/models/task_model.dart';
import 'package:task_manager/repositories/todo_repository_interface.dart';

class TodoRepository implements ITodoRepository {
  Firestore firestore;
  CollectionReference _userReference;

  @override
  Stream<List<Task>> getTodos() {
    this.firestore = Firestore.instance;
    return this.firestore.collection('task').snapshots().map((query) {
      return query.documents.map((doc) {
        return fromDocument(doc);
      }).toList();
    });
  }

  void addTodo(Task task) {
    this.firestore = Firestore.instance;
    this.firestore.collection('task').add(task.toJson());
  }

  void toggleTodo(Task task) {
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

  void toggleImportant(Task task) {
    this.firestore = Firestore.instance;

    task.important = !task.important;
    if (task != null) {
      this
          .firestore
          .collection("task")
          .document(task.id.documentID)
          .updateData({'important': task.important});
    }
  }

  void updateDescription(Task task) {
    this.firestore = Firestore.instance;

    if (task != null) {
      this
          .firestore
          .collection("task")
          .document(task.id.documentID)
          .updateData({'description': task.description});
    }
  }

  void updateCategory(Task task) {
    this.firestore = Firestore.instance;

    if (task != null) {
      this
          .firestore
          .collection("task")
          .document(task.id.documentID)
          .updateData({'category': task.category.toJson()});
    }
  }

  void remove(Task task) {
    this.firestore = Firestore.instance;

    if (task != null) {
      this.firestore.collection("task").document(task.id.documentID).delete();
    }
  }

  Task fromDocument(DocumentSnapshot doc) {
    return Task(
        description: doc['description'],
        done: doc['done'],
        important: doc['important'],
        id: doc.reference,
        category: categoryFromDocument(doc['category']));
  }

  Category categoryFromDocument(Map<String, dynamic> doc) {
    return Category(
        name: doc['name'], imageUrl: doc['imageUrl'], id: doc["id"]);
  }
}
