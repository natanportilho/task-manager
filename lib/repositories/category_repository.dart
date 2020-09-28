import 'package:task_manager/models/category_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_manager/repositories/category_repository_interface.dart';

class CategoryRepository implements ICategoryRepository {
  FirebaseFirestore firestore;

  CategoryRepository(this.firestore);

  @override
  Future<DocumentReference> addCategory(Category category) {
    return this.firestore.collection('category').add(category.toJson());
  }

  @override
  Stream<List<Category>> getCategories() {
    return this.firestore.collection('category').snapshots().map((query) {
      return query.docs.map((doc) {
        return fromDocument(doc);
      }).toList();
    });
  }

// Why cant I have this in the model?
  Category fromDocument(DocumentSnapshot doc) {
    return Category(
        name: doc.get("name"),
        imageUrl: doc.get("imageUrl"),
        id: doc.reference);
  }
}
