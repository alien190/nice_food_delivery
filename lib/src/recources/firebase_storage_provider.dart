import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'resources.dart';
import '../models/models.dart';

class FirebaseStorageProvider implements StorageProvider {
  static const _catalogCollection = 'catalog';
  static const _itemsCollection = 'items';
  static const _userCollection = 'users';
  static const _userCardCollection = 'card';

  static final _instance = FirebaseStorageProvider._internal();

  final _firestoreInstance = Firestore.instance;

  FirebaseStorageProvider._internal();

  factory FirebaseStorageProvider() => _instance;

  @override
  Stream<List<CategoryItemModel>> fetchCategories() {
    return _firestoreInstance
        .collection(_catalogCollection)
        .snapshots()
        .map(_mapCategories);
  }

  List<CategoryItemModel> _mapCategories(QuerySnapshot snapshot) {
    return snapshot.documents
        .map((document) =>
            CategoryItemModel.fromSnapshot(document.data, document.documentID))
        .toList();
  }

  @override
  Stream<List<BaseItemModel>> fetchCategoryItems(
      ItemType itemType, String parentDocumentId) {
    return _firestoreInstance
        .collection(_catalogCollection)
        .document(parentDocumentId)
        .collection(_itemsCollection)
        .snapshots()
        .map((snapshot) => _mapCategoryItems(snapshot, itemType));
  }

  List<BaseItemModel> _mapCategoryItems(
      QuerySnapshot snapshot, ItemType itemType) {
    return snapshot.documents
        .map((document) => ModelsFactory.fromSnapshot(
            document.data, document.documentID, itemType))
        .toList();
  }

  @override
  Future addItemToCard(String userId, CardItemModel cardItem) {
    return _firestoreInstance
        .collection(_userCollection)
        .document(userId)
        .collection(_userCardCollection)
        .add(cardItem.toJson());
  }

  @override
  Stream<List<CardItemModel>> fetchCardItems(Stream<String> userId) {
    return userId.transform(FlatMapStreamTransformer((userId) =>
        _firestoreInstance
            .collection(_userCollection)
            .document(userId)
            .collection(_userCardCollection)
            .orderBy('itemId')
            .snapshots()
            .map(_mapCardItems)));
  }

  List<CardItemModel> _mapCardItems(QuerySnapshot snapshot) {
    final Map<String, CardItemModel> itemsMap = {};

    snapshot.documents.forEach((DocumentSnapshot document) {
      final CardItemModel item =
          CardItemModel.fromSnapshot(document.data, document.documentID);
      final existingItem = itemsMap[item.itemId];
      if (existingItem == null) {
        itemsMap[item.itemId] = item;
      } else {
        itemsMap[item.itemId] =
            CardItemModel.increaseQuantityAndPrice(existingItem, item.price);
      }
    });
    return itemsMap.values.toList();
  }

  Future<void> deleteCardItem(String userId, CardItemModel cardItemModel) {
    return _firestoreInstance
        .collection(_userCollection)
        .document(userId)
        .collection(_userCardCollection)
        .document(cardItemModel.id)
        .delete();
  }

  Future<void> updateCardItem(
      String userId, String id, Map<String, dynamic> data) {
    return _firestoreInstance
        .collection(_userCollection)
        .document(userId)
        .collection(_userCardCollection)
        .document(id)
        .updateData(data);
  }
}
