import '../models/models.dart';
export '../models/models.dart';
export 'food_repository.dart';
export 'firebase_auth_provider.dart';

abstract class StorageProvider {
  Stream<List<CategoryItemModel>> fetchCategories();

  Stream<List<BaseItemModel>> fetchCategoryItems(
      ItemType itemType, String parentDocumentId);

  Future addItemToCard(String userId, CardItemModel cardItem);

  Stream<List<CardItemModel>> fetchCardItems(Stream<String> userId);

  Future<void> deleteCardItem(String userId, CardItemModel cardItemModel);

  Future<void> updateCardItem(
      String userId, String id, Map<String, dynamic> data);
}

abstract class Repository {
  void dispose();

  Stream<List<CategoryItemModel>> fetchCategories();

  Stream<List<BaseItemModel>> fetchCategoryItems(itemType, parentDocumentId);

  Future addItemToCard(CardItemModel cardItem);

  Stream<List<CardItemModel>> fetchCardItems();

  Future<bool> removeItemFromCard(CardItemModel cardItemModel);
}

abstract class AuthProvider {
  Stream<String> get authUserId;

  void dispose();
}
