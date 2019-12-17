import 'package:cloud_firestore/cloud_firestore.dart';
import 'resources.dart';
import '../models/models.dart';

class FirebaseProvider implements StorageProvider {
  static const catalogCollection = 'catalog';
  static const itemsCollection = 'items';

  static final _instance = FirebaseProvider._internal();

  final _firestoreInstance = Firestore.instance;

  FirebaseProvider._internal();

  factory FirebaseProvider() => _instance;

  @override
  Stream<List<CategoryItemModel>> fetchCategories() {
    return _firestoreInstance
        .collection(catalogCollection)
        .snapshots()
        .map(_mapCategory);
  }

  List<CategoryItemModel> _mapCategory(QuerySnapshot snapshot) {
    return snapshot.documents
        .map((document) =>
            CategoryItemModel.fromSnapshot(document.data, document.documentID))
        .toList();
  }

  @override
  Stream<List<BaseItemModel>> fetchCategoryItems(
      ItemType itemType, String parentDocumentId) {
    return _firestoreInstance
        .collection(catalogCollection)
        .document(parentDocumentId)
        .collection(itemsCollection)
        .snapshots()
        .map((snapshot) => _mapCategoryItem(snapshot, itemType));
  }

  List<BaseItemModel> _mapCategoryItem(
      QuerySnapshot snapshot, ItemType itemType) {
    return snapshot.documents
        .map((document) => ModelsFactory.fromSnapshot(
            document.data, document.documentID, itemType))
        .toList();
  }
}
