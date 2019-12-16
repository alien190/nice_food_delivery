import '../models/category_item_model.dart';
import '../models/base_item_model.dart';
import 'firebase_provider.dart';

class Repository {
  static final _instance = Repository._internal();
  final StorageProvider _storageProvider = FirebaseProvider();

  Repository._internal();

  factory Repository() => _instance;

  Stream<List<CategoryItemModel>> fetchCategories() {
    return _storageProvider.fetchCategories();
  }
}

abstract class StorageProvider {
  Stream<List<CategoryItemModel>> fetchCategories();
}
