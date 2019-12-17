import 'firebase_provider.dart';
import 'resources.dart';

class FoodRepository implements Repository {
  static final _instance = FoodRepository._internal();
  final StorageProvider _storageProvider = FirebaseProvider();

  FoodRepository._internal();

  factory FoodRepository() => _instance;

  Stream<List<CategoryItemModel>> fetchCategories() {
    return _storageProvider.fetchCategories();
  }

  @override
  fetchCategoryItems(itemType, parentDocumentId) {
    return _storageProvider.fetchCategoryItems(itemType, parentDocumentId);
  }

  @override
  void dispose() {}
}
