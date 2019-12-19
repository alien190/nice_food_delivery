// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardItemModel _$CardItemModelFromJson(Map<String, dynamic> json) {
  return CardItemModel(
    id: json['id'] as String,
    itemId: json['itemId'] as String,
    name: json['name'] as String,
    price: (json['price'] as num)?.toDouble(),
    pictureUrl: json['pictureUrl'] as String,
    quantity: json['quantity'] as int,
    energy: (json['energy'] as num)?.toDouble(),
    carbohydrates: (json['carbohydrates'] as num)?.toDouble(),
    fats: (json['fats'] as num)?.toDouble(),
    proteins: (json['proteins'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$CardItemModelToJson(CardItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'itemId': instance.itemId,
      'name': instance.name,
      'price': instance.price,
      'pictureUrl': instance.pictureUrl,
      'quantity': instance.quantity,
      'energy': instance.energy,
      'carbohydrates': instance.carbohydrates,
      'fats': instance.fats,
      'proteins': instance.proteins,
    };
