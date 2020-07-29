import 'package:task_manager/models/category_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_manager/repositories/category_repository_interface.dart';

class CategoryRepository implements ICategoryRepository {
  Firestore firestore;
  CollectionReference _userReference;
  @override
  Future<DocumentReference> addCategory(Category category) {
    this.firestore = Firestore.instance;
    return this.firestore.collection('category').add(category.toJson());
  }

  @override
  Stream<List<Category>> getCategories() {
    this.firestore = Firestore.instance;
    return this.firestore.collection('category').snapshots().map((query) {
      return query.documents.map((doc) {
        return fromDocument(doc);
      }).toList();
    });
  }

// Why cant I have this in the model?
  Category fromDocument(DocumentSnapshot doc) {
    return Category(
        name: doc['name'], imageUrl: doc['imageUrl'], id: doc.reference);
  }
}
