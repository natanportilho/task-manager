// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/models/task_model.dart';
import 'package:task_manager/pages/home_page.dart';
import 'package:task_manager/repositories/category_repository_interface.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_manager/repositories/todo_repository.dart';
import 'package:task_manager/repositories/todo_repository_interface.dart';
import 'package:task_manager/services/firebase_service.dart';
import 'package:task_manager/stores/store_category.dart';
import 'package:task_manager/stores/task_store.dart';

//class TodoRepositoryMock extends Mock implements ITodoRepository {}

class CategoryRepositoyMock extends Mock implements ICategoryRepository {
  CategoryRepositoyMock(FirestoreMock firestore);
}

class TodoRepositoryMock extends Mock implements ITodoRepository {
  TodoRepositoryMock(MockFirestoreInstance firestore);
}

class DocumentReferenceMock extends Mock implements DocumentReference {}

class FirestoreMock extends Mock implements FirebaseFirestore {}

class TaskMock extends Mock implements Task {}

class TaskStoreMock extends Mock implements TaskStore {}

class CategoryStoreMock extends Mock implements CategoryStore {}

class CollectionReferenceMock extends Mock implements CollectionReference {}

class FirebaseServiceMock extends Mock {
  static final FirebaseServiceMock _singleton = FirebaseServiceMock._internal();
  MockFirestoreInstance instance = MockFirestoreInstance();

  factory FirebaseServiceMock() {
    return _singleton;
  }

  FirebaseServiceMock._internal();
}

void main() {
  group("Test Pages", () {
    test('get tasks', () async {
      FirebaseServiceMock firebaseServiceMock = FirebaseServiceMock();

      await firebaseServiceMock.instance.collection('task').add(
          {'description': 'Hello world!', 'done': false, 'important': true});

      final DocumentReferenceMock mockDocumentRef = DocumentReferenceMock();
      Task task = Task();
      task.id = mockDocumentRef;
      task.description = 'lololo';
      task.done = true;
      task.important = false;

      final TaskStore taskStore =
          TaskStore.testConstructor(firebaseServiceMock.instance);

      taskStore.add(task);

      var todos = await taskStore.todos.data;

      // this is null but task store has the values. Why is it null?
      print(todos);
    });
  });
}
