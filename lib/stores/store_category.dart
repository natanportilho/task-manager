import 'package:mobx/mobx.dart';
import 'package:task_manager/models/category_model.dart';
part 'store_category.g.dart';

class CategoryStore = _CategoryStore with _$CategoryStore;

abstract class _CategoryStore with Store {
  @observable
  var categories = ObservableList<Category>();

  @action
  void add(Category category) {
    categories.add(category);
  }
}
