import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'card_sum_model.g.dart';

@JsonSerializable()
class CardSumModel {
  final double price;
  final int quantity;
  final double energy;
  final double carbohydrates;
  final double fats;
  final double proteins;

  CardSumModel({
    @required this.price,
    @required this.quantity,
    @required this.energy,
    @required this.carbohydrates,
    @required this.fats,
    @required this.proteins,
  });

  bool isEmpty() {
    return quantity == 0;
  }

  bool isNotEmpty() {
    return quantity > 0;
  }

  factory CardSumModel.fromJson(Map<String, dynamic> json) =>
      _$CardSumModelFromJson(json);

  Map<String, dynamic> toJson() => _$CardSumModelToJson(this);

  factory CardSumModel.empty() => CardSumModel(
        price: 0,
        fats: 0,
        proteins: 0,
        energy: 0,
        carbohydrates: 0,
        quantity: 0,
      );
}
