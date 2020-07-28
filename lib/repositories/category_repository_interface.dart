import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_manager/models/category_model.dart';

abstract class ICategoryRepository {
  Stream<List<Category>> getCategories();

  Future<DocumentReference> addCategory(Category category);
}
