import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_manager/models/category_model.dart';
import 'package:task_manager/models/task_model.dart';
import 'package:task_manager/repositories/todo_repository_interface.dart';

class TodoRepository implements ITodoRepository {
  TodoRepository(this.firestore);
  FirebaseFirestore firestore;

  @override
  Stream<List<Task>> getTodos() {
    this.firestore = FirebaseFirestore.instance;
    return this.firestore.collection('task').snapshots().map((query) {
      return query.docs.map((doc) {
        return fromDocument(doc);
      }).toList();
    });
  }

  void addTodo(Task task) {
    this.firestore = FirebaseFirestore.instance;
    this.firestore.collection('task').add(task.toJson());
  }

  void toggleTodo(Task task) {
    this.firestore = FirebaseFirestore.instance;

    task.done = !task.done;
    if (task != null) {
      this
          .firestore
          .collection("task")
          .doc(task.id.id)
          .update({'done': task.done});
    }
  }

  void toggleImportant(Task task) {
    this.firestore = FirebaseFirestore.instance;

    task.important = !task.important;
    if (task != null) {
      this
          .firestore
          .collection("task")
          .doc(task.id.id)
          .update({'important': task.important});
    }
  }

  void updateDescription(Task task) {
    this.firestore = FirebaseFirestore.instance;

    if (task != null) {
      this
          .firestore
          .collection("task")
          .doc(task.id.id)
          .update({'description': task.description});
    }
  }

  void updateCategory(Task task) {
    this.firestore = FirebaseFirestore.instance;

    if (task != null) {
      this
          .firestore
          .collection("task")
          .doc(task.id.id)
          .update({'category': task.category.toJson()});
    }
  }

  void remove(Task task) {
    this.firestore = FirebaseFirestore.instance;

    if (task != null) {
      this.firestore.collection("task").doc(task.id.id).delete();
    }
  }

  Task fromDocument(DocumentSnapshot doc) {
    return Task(
        description: doc.get("description"),
        done: doc.get("done"),
        important: doc.get("Important"),
        id: doc.reference,
        category: categoryFromDocument(doc.get("category")));
  }

  Category categoryFromDocument(Map<String, dynamic> doc) {
    return Category(
        name: doc['name'], imageUrl: doc['imageUrl'], id: doc["id"]);
  }
}
