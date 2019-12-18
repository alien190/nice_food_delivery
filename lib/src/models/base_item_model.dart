import 'package:meta/meta.dart';

class BaseItemModel {
  final String id;
  final String name;
  final double price;
  final double energy;
  final double carbohydrates;
  final double fats;
  final double proteins;
  final List<String> ingredients;
  final String pictureUrl;

  BaseItemModel({
    @required this.id,
    @required this.name,
    @required this.price,
    @required this.ingredients,
    @required this.proteins,
    @required this.fats,
    @required this.carbohydrates,
    @required this.energy,
    @required this.pictureUrl,
  });


}
