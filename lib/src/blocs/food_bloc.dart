import '../recources/resources.dart';

class FoodBloc {
  final Repository _repository;
  ItemType _itemType;
  String _parentDocumentId;
  Stream<List<BaseItemModel>> _itemsStream;

  FoodBloc(this._repository);

  Stream<List<CategoryItemModel>> fetchCategories() {
    return _repository.fetchCategories();
  }

  Stream<List<BaseItemModel>> fetchCategoryItems(
      ItemType itemType, String parentDocumentId) {
    if (_itemsStream != null &&
        _itemType == itemType &&
        _parentDocumentId == parentDocumentId) {
      return _itemsStream;
    }
    _itemsStream = _itemsStream =
        _repository.fetchCategoryItems(itemType, parentDocumentId);
    return _itemsStream;
  }

  void dispose() {}
}
