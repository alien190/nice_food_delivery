// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseItemModel _$BaseItemModelFromJson(Map<String, dynamic> json) {
  return BaseItemModel(
    id: json['id'] as String,
    name: json['name'] as String,
    price: (json['price'] as num)?.toDouble(),
    ingredients:
        (json['ingredients'] as List)?.map((e) => e as String)?.toList(),
    proteins: (json['proteins'] as num)?.toDouble(),
    fats: (json['fats'] as num)?.toDouble(),
    carbohydrates: (json['carbohydrates'] as num)?.toDouble(),
    energy: (json['energy'] as num)?.toDouble(),
    pictureUrl: json['pictureUrl'] as String,
  );
}

Map<String, dynamic> _$BaseItemModelToJson(BaseItemModel instance) =>
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
    };
