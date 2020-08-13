import 'package:task_manager/models/task_model.dart';

abstract class ITodoRepository {
  Stream<List<Task>> getTodos();

  void addTodo(Task task);

  void toggleTodo(Task task);

  void updateDescription(Task task);

  void updateCategory(Task task);

  void remove(Task task);
}
