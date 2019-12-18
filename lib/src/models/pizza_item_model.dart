import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'base_item_model.dart';

part 'pizza_item_model.g.dart';

@JsonSerializable()
class PizzaItemModel extends BaseItemModel {
  final int quantity;
  final int weigh;

  PizzaItemModel({
    @required String id,
    @required String name,
    @required double price,
    @required double energy,
    @required double carbohydrates,
    @required double fats,
    @required double proteins,
    @required List<String> ingredients,
    @required String pictureUrl,
    @required this.quantity,
    @required this.weigh,
  }) : super(
            id: id,
            name: name,
            price: price,
            energy: energy,
            carbohydrates: carbohydrates,
            fats: fats,
            ingredients: ingredients,
            proteins: proteins,
            pictureUrl: pictureUrl,);

  factory PizzaItemModel.fromSnapshot(Map<String, dynamic> map, String id) {
    map['id'] = id;
    return _$PizzaItemModelFromJson(map);
  }
}
