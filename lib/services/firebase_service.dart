import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  static final FirebaseService _singleton = FirebaseService._internal();
  FirebaseFirestore instance = FirebaseFirestore.instance;

  factory FirebaseService() {
    return _singleton;
  }

  FirebaseService._internal();
}
