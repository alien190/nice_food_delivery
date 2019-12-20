import 'dart:async';

import 'firebase_storage_provider.dart';
import 'resources.dart';

class FoodRepository implements Repository {
  static final _instance = FoodRepository._internal();
  final StorageProvider _storageProvider = FirebaseStorageProvider();
  final AuthProvider _authProvider = FirebaseAuthProvider();

  FoodRepository._internal();

  Future<String> _getUserId() async {
    return await _authProvider.authUserId.first;
  }

  Stream<String> _getUserIdStream() {
    return _authProvider.authUserId;
  }

  factory FoodRepository() => _instance;

  Stream<List<CategoryItemModel>> fetchCategories() {
    return _storageProvider.fetchCategories();
  }

  @override
  fetchCategoryItems(itemType, parentDocumentId) {
    return _storageProvider.fetchCategoryItems(itemType, parentDocumentId);
  }

  @override
  Future addItemToCard(CardItemModel cardItem) async {
    final String userId = await _getUserId();
    return _storageProvider.addItemToCard(userId, cardItem);
  }

  @override
  Stream<List<CardItemModel>> fetchCardItems() {
    return _storageProvider.fetchCardItems(_getUserIdStream());
  }

  @override
  Future<bool> removeItemFromCard(CardItemModel cardItemModel) async {
    final String userId = await _getUserId();
    await _storageProvider.deleteCardItem(userId, cardItemModel);
    return true;
  }

  @override
  Future<void> addOrder(OrderModel order) async {
    final String userId = await _getUserId();
    await _storageProvider.addOrder(userId, order);
    await _storageProvider.clearCard(userId);
  }

  @override
  Stream<List<OrderModel>> fetchOrders() {
    return _storageProvider.fetchOrders(_getUserIdStream());
  }

  @override
  void dispose() {
    _authProvider.dispose();
  }
}
