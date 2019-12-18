import '../recources/resources.dart';
import '../models/models.dart';

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

  Future addItemToCard(BaseItemModel item) async {
    final cardItem = CardItemModel(
      id: '',
      itemId: item.id,
      name: item.name,
      pictureUrl: item.pictureUrl,
      price: item.price,
    );
    return _repository.addItemToCard(cardItem);
  }

  void dispose() {
    _repository.dispose();
  }
}
