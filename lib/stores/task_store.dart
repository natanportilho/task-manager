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
    _updateTask(getTaksById(taskId)..category = category);
  }

  @action
  void toggleDoneFlag(int taskId) {
    Task task = getTaksById(taskId);
    task.done = !task.done;
    _updateTask(task);
  }

  @action
  void updateDescription(int taskId, String description) {
    _updateTask(getTaksById(taskId)..description = description);
  }

  @action
  void remove(Task task) {
    tasks.remove(task);
  }

  Task getTaksById(int taskId) {
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
