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
  void dispose() {
    _authProvider.dispose();
  }
}
