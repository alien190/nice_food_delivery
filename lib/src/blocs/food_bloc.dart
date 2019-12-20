import 'dart:async';
import 'package:rxdart/rxdart.dart';

import '../recources/resources.dart';
import '../models/models.dart';

class FoodBloc {
  final Repository _repository;
  ItemType _itemType;
  String _parentDocumentId;
  Stream<List<BaseItemModel>> _itemsStream;
  final _cardItemSum = BehaviorSubject<CardSumModel>();

  Stream<CardSumModel> get cardItemSum => _cardItemSum.stream;

  FoodBloc(this._repository) {
    _repository.fetchCardItems().listen((List<CardItemModel> items) {
      double price = 0;
      double energy = 0;
      double carbohydrates = 0;
      double fats = 0;
      double proteins = 0;
      int quantity = 0;

      items.forEach((item) {
        price += item.price;
        energy += item.energy * item.quantity;
        carbohydrates += item.carbohydrates * item.quantity;
        fats += item.fats * item.quantity;
        proteins += item.proteins * item.quantity;
        quantity += item.quantity;
      });

      _cardItemSum.add(CardSumModel(
        price: price,
        quantity: quantity,
        energy: energy,
        carbohydrates: carbohydrates,
        fats: fats,
        proteins: proteins,
      ));
    }, onError: _cardItemSum.addError);
  }

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
    _itemsStream = _repository.fetchCategoryItems(itemType, parentDocumentId);
    return _itemsStream;
  }

  Future addItemToCard(BaseItemModel item) async {
    final cardItem = CardItemModel(
      id: '',
      itemId: item.id,
      name: item.name,
      pictureUrl: item.pictureUrl,
      price: item.price,
      quantity: 1,
      carbohydrates: item.carbohydrates,
      energy: item.energy,
      proteins: item.proteins,
      fats: item.fats,
    );
    return _repository.addItemToCard(cardItem);
  }

  Future<bool> removeItemFromCard(CardItemModel cardItemModel) async {
    _repository.removeItemFromCard(cardItemModel);
    return cardItemModel.quantity == 1;
  }

  Stream<List<CardItemModel>> fetchCardItems() {
    return _repository.fetchCardItems();
  }

  void dispose() {
    _repository.dispose();
    _cardItemSum.close();
  }
}
