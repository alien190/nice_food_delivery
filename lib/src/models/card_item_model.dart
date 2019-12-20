import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';

part 'card_item_model.g.dart';

@JsonSerializable()
class CardItemModel {
  final String id;
  final String itemId;
  final String name;
  final double price;
  final String pictureUrl;
  final int quantity;
  final double energy;
  final double carbohydrates;
  final double fats;
  final double proteins;

  CardItemModel({
    @required this.id,
    @required this.itemId,
    @required this.name,
    @required this.price,
    @required this.pictureUrl,
    @required this.quantity,
    @required this.energy,
    @required this.carbohydrates,
    @required this.fats,
    @required this.proteins,
  });

  factory CardItemModel.copyWith(
    CardItemModel item, {
    String id,
    String itemId,
    String name,
    double price,
    String pictureUrl,
    int quantity,
    double energy,
    double carbohydrates,
    double fats,
    double proteins,
  }) {
    return CardItemModel(
      id: id ?? item.id,
      itemId: itemId ?? item.itemId,
      name: name ?? item.name,
      price: price ?? item.price,
      pictureUrl: pictureUrl ?? item.pictureUrl,
      quantity: quantity ?? item.quantity,
      carbohydrates: carbohydrates ?? item.carbohydrates,
      fats: fats ?? item.fats,
      proteins: proteins ?? item.proteins,
      energy: energy ?? item.energy,
    );
  }

  factory CardItemModel.increaseQuantity(CardItemModel item) {
    return CardItemModel.copyWith(
      item,
      quantity: item.quantity + 1,
    );
  }

  factory CardItemModel.increaseQuantityAndPrice(
      CardItemModel item, double price) {
    return CardItemModel.copyWith(
      item,
      quantity: item.quantity + 1,
      price: item.price + price,
    );
  }

  factory CardItemModel.decreaseQuantity(CardItemModel item) {
    return CardItemModel.copyWith(
      item,
      quantity: item.quantity - 1,
    );
  }

  factory CardItemModel.fromSnapshot(Map<String, dynamic> map, String id) {
    map['id'] = id;
    return _$CardItemModelFromJson(map);
  }

  factory CardItemModel.fromJson(Map<String, dynamic> map) {
    return _$CardItemModelFromJson(map);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = _$CardItemModelToJson(this);
    map.remove('id');
    return map;
  }
}
