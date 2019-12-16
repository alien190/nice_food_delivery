import 'package:cloud_firestore/cloud_firestore.dart';
import 'repository.dart';
import '../models/category_item_model.dart';

class FirebaseProvider implements StorageProvider {
  static const catalogCollection = 'catalog';

  static final _instance = FirebaseProvider._internal();

  final _firestoreInstance = Firestore.instance;

  FirebaseProvider._internal();

  factory FirebaseProvider() => _instance;

  @override
  Stream<List<CategoryItemModel>> fetchCategories() {
    return _firestoreInstance
        .collection(catalogCollection)
        .snapshots()
        .map(_map);
  }

  List<CategoryItemModel> _map(QuerySnapshot snapshot) {
    return snapshot.documents
        .map((document) =>
            CategoryItemModel.fromSnapshot(document.data, document.documentID))
        .toList();
  }
}
