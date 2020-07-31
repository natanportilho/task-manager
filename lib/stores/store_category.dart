import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';
import 'package:task_manager/models/category_model.dart';
import 'package:task_manager/repositories/category_repository.dart';
import 'package:task_manager/repositories/category_repository_interface.dart';
part 'store_category.g.dart';

class CategoryStore = _CategoryStore with _$CategoryStore;

abstract class _CategoryStore with Store {
  // Shoudl get categories from Firebase
  ICategoryRepository categoryRepository = CategoryRepository();

  @observable
  ObservableStream<List<Category>> categories;

  _CategoryStore() {
    getCategories();
  }

  @action
  ObservableList<Category> getCategories() {
    categories = categoryRepository.getCategories().asObservable();
  }

  @action
  Future<void> add(Category category) async {
    DocumentReference ref = await categoryRepository.addCategory(category);
    category.id = ref;
  }

  Category getCategoryByName(String name) {
    List<Category> myCategories = categories.data;
    return myCategories.firstWhere((c) => c.name == name);
  }
}
