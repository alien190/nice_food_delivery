import 'package:meta/meta.dart';
import 'base_item_model.dart';

class SushiItemModel extends BaseItemModel {
  final int quantity;
  final int weigh;

  SushiItemModel({
    @required String id,
    @required String name,
    @required double price,
    @required int energy,
    @required double carbohydrates,
    @required double fats,
    @required double proteins,
    @required List<String> ingredients,
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
            proteins: proteins);
}
