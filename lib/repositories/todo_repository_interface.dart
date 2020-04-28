import 'package:task_manager/models/todo_model.dart';

abstract class ITodoRepository {

  Stream<List<TodoModel>> getTodos();

}
