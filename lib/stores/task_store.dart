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
  Task updateCategory(int taskId, Category category) {
    Task task = _getTaksById(taskId);
    task.category = category;
    _updateTask(task);
  }

  @action
  void toggleDoneFlag(int taskId) {
    Task task = _getTaksById(taskId);
    task.done = !task.done;
    _updateTask(task);
  }

  _getTaksById(int taskId) {
    return tasks.firstWhere((t) => t.id == taskId);
  }

  _updateTask(Task task) {
    for (var i = 0; i < tasks.length; i++) {
      if (tasks[i].id == task.id) {
        tasks[i] = task;
      }
    }
  }
}
