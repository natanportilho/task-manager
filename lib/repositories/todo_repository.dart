import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_manager/models/todo_model.dart';
import 'package:task_manager/repositories/todo_repository_interface.dart';

class TodoRepository implements ITodoRepository {
  Firestore firestore;

  @override
  Stream<List<TodoModel>> getTodos() {
    this.firestore = Firestore.instance;
    return this.firestore.collection('task').snapshots().map((query) {
      return query.documents.map((doc) {
        return TodoModel.fromDocument(doc);
      });
    });
  }
}
