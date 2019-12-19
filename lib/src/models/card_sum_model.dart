import 'package:flutter/material.dart';

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
}
