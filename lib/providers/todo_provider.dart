// import 'package:flutter/material.dart';
// import 'package:task_manager/persistence/todo_table.dart';

// class TodoProvider extends ChangeNotifier {

//   final database = MyDatabase();
//   List<Todo> entries = <Todo>[];

//   addTodo(String category, String name, String description) {

//     database.addTodo(Todo(name: name, description: description));

//     database.allTodoEntries.then((list) => {
//           entries = list,
//         });
//     notifyListeners();
//   }

//   removeAll(int i) {
//     database.removeTodo(i).then((a) => {
//           database.allTodoEntries.then((list) => {
//                 entries = list,
//               }),
//           notifyListeners(),
//         });
//   }

//   remove(Todo todo) {
//     database.removeAll();
//   }

//   saveAsDone(Todo todo) {}

//   saveAsNotDone(Todo todo) {}
// }
