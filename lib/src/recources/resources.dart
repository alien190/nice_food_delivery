import '../models/models.dart';
export '../models/models.dart';
export 'food_repository.dart';
export 'firebase_auth_provider.dart';

abstract class StorageProvider {
  Stream<List<CategoryItemModel>> fetchCategories();

  Stream<List<BaseItemModel>> fetchCategoryItems(
      ItemType itemType, String parentDocumentId);

  Future addItemToCard(String userId, CardItemModel cardItem);
}

abstract class Repository {
  void dispose();

  Stream<List<CategoryItemModel>> fetchCategories();

  fetchCategoryItems(itemType, parentDocumentId);

  Future addItemToCard(CardItemModel cardItem);
}

abstract class AuthProvider {
  Stream<String> get authUserId;

  void dispose();
}
