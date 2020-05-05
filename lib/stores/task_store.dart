import 'package:mobx/mobx.dart';
import 'package:task_manager/models/category_model.dart';
import 'package:task_manager/models/task_model.dart';
part 'task_store.g.dart';

class TaskStore = _TaskStore with _$TaskStore;

abstract class _TaskStore with Store {
  @observable
  var tasks = ObservableList<Task>();

  @action
  void add(Task task) {
    tasks.add(task);
  }

  @action
  void updateCategory(int taskId, Category category) {
    Task task = tasks.firstWhere((t) => t.id == taskId);
    task.category = category;
    for (var i = 0; i < tasks.length; i++) {
      if (tasks[i].id == taskId) {
        tasks[i] = task;
      }
    }
  }
}
