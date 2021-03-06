// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pizza_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PizzaItemModel _$PizzaItemModelFromJson(Map<String, dynamic> json) {
  return PizzaItemModel(
    id: json['id'] as String,
    name: json['name'] as String,
    price: (json['price'] as num)?.toDouble(),
    energy: (json['energy'] as num)?.toDouble(),
    carbohydrates: (json['carbohydrates'] as num)?.toDouble(),
    fats: (json['fats'] as num)?.toDouble(),
    proteins: (json['proteins'] as num)?.toDouble(),
    ingredients:
        (json['ingredients'] as List)?.map((e) => e as String)?.toList(),
    pictureUrl: json['pictureUrl'] as String,
    quantity: json['quantity'] as int,
    weigh: json['weigh'] as int,
  );
}

Map<String, dynamic> _$PizzaItemModelToJson(PizzaItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'energy': instance.energy,
      'carbohydrates': instance.carbohydrates,
      'fats': instance.fats,
      'proteins': instance.proteins,
      'ingredients': instance.ingredients,
      'pictureUrl': instance.pictureUrl,
      'quantity': instance.quantity,
      'weigh': instance.weigh,
    };
