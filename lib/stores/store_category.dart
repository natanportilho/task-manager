import 'package:mobx/mobx.dart';
import 'package:task_manager/models/category_model.dart';
part 'store_category.g.dart';

class CategoryStore = _CategoryStore with _$CategoryStore;

abstract class _CategoryStore with Store {
  _CategoryStore() {
    categories.add(Category(id: 1, name: "Personal"));
    categories.add(Category(id: 2, name: "Study"));
    categories.add(Category(id: 3, name: "Work"));
  }

  @observable
  var categories = ObservableList<Category>();

  @action
  void add(Category category) {
    categories.add(category);
  }

  Category getCategoryByName(String name) {
    return categories.firstWhere((c) => c.name == name);
  }
}
