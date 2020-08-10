import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';
import 'package:task_manager/models/task_model.dart';
import 'package:task_manager/repositories/todo_repository.dart';
import 'package:task_manager/repositories/todo_repository_interface.dart';
part 'task_store.g.dart';

class TaskStore = _TaskStore with _$TaskStore;

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
  updateDescription(Task task, String description) {
    task.description = description;
    todoRepository.updateDescription(task);
  }
}
