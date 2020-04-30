import 'package:mobx/mobx.dart';
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
}
