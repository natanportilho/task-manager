// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_category.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CategoryStore on _CategoryStore, Store {
  final _$categoriesAtom = Atom(name: '_CategoryStore.categories');

  @override
  ObservableList<Category> get categories {
    _$categoriesAtom.context.enforceReadPolicy(_$categoriesAtom);
    _$categoriesAtom.reportObserved();
    return super.categories;
  }

  @override
  set categories(ObservableList<Category> value) {
    _$categoriesAtom.context.conditionallyRunInAction(() {
      super.categories = value;
      _$categoriesAtom.reportChanged();
    }, _$categoriesAtom, name: '${_$categoriesAtom.name}_set');
  }

  final _$_CategoryStoreActionController =
      ActionController(name: '_CategoryStore');

  @override
  void add(Category category) {
    final _$actionInfo = _$_CategoryStoreActionController.startAction();
    try {
      return super.add(category);
    } finally {
      _$_CategoryStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string = 'categories: ${categories.toString()}';
    return '{$string}';
  }
}
