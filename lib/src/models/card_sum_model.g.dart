// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_sum_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardSumModel _$CardSumModelFromJson(Map<String, dynamic> json) {
  return CardSumModel(
    price: (json['price'] as num)?.toDouble(),
    quantity: json['quantity'] as int,
    energy: (json['energy'] as num)?.toDouble(),
    carbohydrates: (json['carbohydrates'] as num)?.toDouble(),
    fats: (json['fats'] as num)?.toDouble(),
    proteins: (json['proteins'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$CardSumModelToJson(CardSumModel instance) =>
    <String, dynamic>{
      'price': instance.price,
      'quantity': instance.quantity,
      'energy': instance.energy,
      'carbohydrates': instance.carbohydrates,
      'fats': instance.fats,
      'proteins': instance.proteins,
    };
