import 'package:task_manager/models/category_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_manager/repositories/category_repository_interface.dart';

class CategoryRepository implements ICategoryRepository {
  @override
  Future<DocumentReference> addCategory(Category category) {
    // TODO: implement addCategory
    throw UnimplementedError();
  }

  @override
  Stream<List<Category>> getCategories() {
    // TODO: implement getCategories
    throw UnimplementedError();
  }

}
