import '../models/models.dart';
export '../models/models.dart';
import 'food_repository.dart';
export 'food_repository.dart';

abstract class StorageProvider {
  Stream<List<CategoryItemModel>> fetchCategories();

  Stream<List<BaseItemModel>> fetchCategoryItems(
      ItemType itemType, String parentDocumentId);
}

abstract class Repository {
  void dispose();

  Stream<List<CategoryItemModel>> fetchCategories();

  fetchCategoryItems(itemType, parentDocumentId);
}
