import 'package:mobx/mobx.dart';
import 'package:task_manager/models/category_model.dart';
part 'store_category.g.dart';

class CategoryStore = _CategoryStore with _$CategoryStore;

abstract class _CategoryStore with Store {
  _CategoryStore() {
    categories.add(Category(
        id: 1,
        name: "Personal",
        imageUrl:
            'https://images.unsplash.com/photo-1462926703708-44ab9e271d97?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=564&q=80'));
    categories.add(Category(
        id: 2,
        name: "Study",
        imageUrl:
            'https://images.unsplash.com/photo-1494498902093-87f291949d17?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60'));
    categories.add(Category(
        id: 3,
        name: "Work",
        imageUrl:
            'https://images.unsplash.com/photo-1537202108838-e7072bad1927?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=685&q=80'));
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
