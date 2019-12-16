import 'package:meta/meta.dart';

class BaseItemModel {
  final String id;
  final String name;
  final double price;
  final int energy;
  final double carbohydrates;
  final double fats;
  final double proteins;
  final List<String> ingredients;

  BaseItemModel({
    @required this.id,
    @required this.name,
    @required this.price,
    @required this.ingredients,
    @required this.proteins,
    @required this.fats,
    @required this.carbohydrates,
    @required this.energy,
  });
}
