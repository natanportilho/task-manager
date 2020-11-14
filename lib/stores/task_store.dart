import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';
import 'package:task_manager/models/category_model.dart';
import 'package:task_manager/models/task_model.dart';
import 'package:task_manager/repositories/todo_repository.dart';
import 'package:task_manager/repositories/todo_repository_interface.dart';
import 'package:task_manager/services/firebase_service.dart';
part 'task_store.g.dart';

class TaskStore = _TaskStore with _$TaskStore;

abstract class _TaskStore with Store {
  FirebaseService firebaseService;

  // FirebaseService firebaseService = FirebaseService();
  ITodoRepository todoRepository;
  @observable
  ObservableStream<List<Task>> todos;

  _TaskStore(FirebaseService firebaseService) {
    this.firebaseService = firebaseService;
    todoRepository = TodoRepository(this.firebaseService.instance);
    getTodos();
  }

  _TaskStore.testConstructor(FirebaseFirestore firebaseFirestore) {
    todoRepository = TodoRepository(firebaseFirestore);
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
  toggleImportant(Task task) {
    todoRepository.toggleImportant(task);
  }

  @action
  Future<void> add(Task task) {
    todoRepository.addTodo(task);
  }

  remove(Task task) async {
    todoRepository.remove(task);
  }

  @action
  updateDescription(Task task, String description) {
    task.description = description;
    todoRepository.updateDescription(task);
  }

  @action
  updateCategory(Task task, Category category) {
    task.category = category;
    todoRepository.updateCategory(task);
  }
}
