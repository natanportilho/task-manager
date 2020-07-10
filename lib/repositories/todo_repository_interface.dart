import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_manager/models/task_model.dart';

abstract class ITodoRepository {
  Stream<List<Task>> getTodos();

  Future<DocumentReference> addTodo(Task task);
}
