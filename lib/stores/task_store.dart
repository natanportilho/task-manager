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

  Iterable<Task> getTasks() {
    return tasks.where((t) => t != null);
  }

  Stream lol(){
    return Stream.fromIterable(getTasks());
  }

// tasks.map((element) => null)
  // Future convert(Task task) {
  //   return new Future.value(task);
  // }

  // Stream<List<Task>> doStuff(ObservableList<Task> things) {
  //   return new Stream.fromIterable(things
  //       .map((t) async => await convert(t))
  //       .where((value) => value != null));
  // }
}
