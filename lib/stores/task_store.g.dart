// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TaskStore on _TaskStore, Store {
  final _$tasksAtom = Atom(name: '_TaskStore.tasks');

  @override
  ObservableList<Task> get tasks {
    _$tasksAtom.context.enforceReadPolicy(_$tasksAtom);
    _$tasksAtom.reportObserved();
    return super.tasks;
  }

  @override
  set tasks(ObservableList<Task> value) {
    _$tasksAtom.context.conditionallyRunInAction(() {
      super.tasks = value;
      _$tasksAtom.reportChanged();
    }, _$tasksAtom, name: '${_$tasksAtom.name}_set');
  }

  final _$_TaskStoreActionController = ActionController(name: '_TaskStore');

  @override
  void add(Task task) {
    final _$actionInfo = _$_TaskStoreActionController.startAction();
    try {
      return super.add(task);
    } finally {
      _$_TaskStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  Task updateCategory(int taskId, Category category) {
    final _$actionInfo = _$_TaskStoreActionController.startAction();
    try {
      return super.updateCategory(taskId, category);
    } finally {
      _$_TaskStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleDoneFlag(int taskId) {
    final _$actionInfo = _$_TaskStoreActionController.startAction();
    try {
      return super.toggleDoneFlag(taskId);
    } finally {
      _$_TaskStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateDescription(int taskId, String description) {
    final _$actionInfo = _$_TaskStoreActionController.startAction();
    try {
      return super.updateDescription(taskId, description);
    } finally {
      _$_TaskStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void remove(Task task) {
    final _$actionInfo = _$_TaskStoreActionController.startAction();
    try {
      return super.remove(task);
    } finally {
      _$_TaskStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string = 'tasks: ${tasks.toString()}';
    return '{$string}';
  }
}
