import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';
import 'package:task_manager/models/category_model.dart';
import 'package:task_manager/models/task_model.dart';
import 'package:task_manager/repositories/todo_repository.dart';
import 'package:task_manager/repositories/todo_repository_interface.dart';
part 'task_store.g.dart';

class TaskStore = _TaskStore with _$TaskStore;

//TODO: This class must create TaskModels in firebase (this works) and update those as well as get them (How do we update the observable list?)
abstract class _TaskStore with Store {
  ITodoRepository todoRepository = TodoRepository();

  @observable
  ObservableStream<List<Task>> todos;

  _TaskStore() {
    getTodos();
  }

  @action
  getTodos() {
    todos = todoRepository.getTodos().asObservable();
  }

  @action
  toggleTodo(Task task) {
    todoRepository.toggleTodo(task);
  }

  @action
  Future<void> add(Task task) async {
    DocumentReference ref = await todoRepository.addTodo(task);
    task.id = ref;
  }

  @action
  Task updateCategory(String taskId, Category category) {
    _updateTask(getTaksById(taskId)..category = category);
  }

  @action
  void toggleDoneFlag(String taskId) {
    Task task = getTaksById(taskId);
    task.done = !task.done;
    _updateTask(task);
  }

  @action
  void updateDescription(String taskId, String description) {
    _updateTask(getTaksById(taskId)..description = description);
  }

  @action
  void remove(Task task) {
    tasks.remove(task);
  }

  Task getTaksById(String taskId) {
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
