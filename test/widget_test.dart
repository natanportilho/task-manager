// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_manager/models/task_model.dart';
import 'package:task_manager/repositories/category_repository_interface.dart';
import 'package:task_manager/repositories/todo_repository.dart';
import 'package:task_manager/repositories/todo_repository_interface.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_manager/stores/task_store.dart';
import 'package:mobx/mobx.dart' as mobx;

//class TodoRepositoryMock extends Mock implements ITodoRepository {}

class CategoryRepositoyMock extends Mock implements ICategoryRepository {}

class DocumentReferenceMock extends Mock implements DocumentReference {}

class FirestoreMock extends Mock implements Firestore {}

class TaskMock extends Mock implements Task {}

class TaskStoreMock extends Mock implements TaskStore {}

class CollectionReferenceMock extends Mock implements CollectionReference {}

void main() {
  group("group: tasks", () {
    test('get tasks', () {
      //@observable
      //ObservableStream<List<Task>> todos;

      WidgetsFlutterBinding.ensureInitialized();
      final firestore = FirestoreMock();
      final taskStore = TaskStoreMock();

      final CollectionReference mockCollectionReference =
          CollectionReferenceMock();
      //ITodoRepository todoRepository = TodoRepository(Firestore.instance);

      ITodoRepository todoRepository = TodoRepository(firestore);
      final DocumentReferenceMock mockDocumentRef = DocumentReferenceMock();
      TaskMock task = TaskMock();


      when(task.id).thenReturn(mockDocumentRef);
      when(task.description).thenReturn("description");

      print(task.description);

      when(firestore.collection("task")).thenReturn(mockCollectionReference);
      when(taskStore.todoRepository).thenReturn(todoRepository);
      when(taskStore.todos)
          .thenAnswer((_) => todoRepository.getTodos().asObservable());

      taskStore.add(task);
      List<TaskMock> myTodos = taskStore.todos.data;

      expect(myTodos.length, 1);
    });
  });
}

asyncFunction() {}
