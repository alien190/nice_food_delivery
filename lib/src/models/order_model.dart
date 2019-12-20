import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';

import 'models.dart';

part 'order_model.g.dart';

enum OrderStatus {
  Placed,
  InProgress,
  Done,
}

@JsonSerializable(explicitToJson: true, anyMap: true)
class OrderModel {
  final List<CardItemModel> items;
  final CardSumModel cardSum;
  final int dateTime;
  final OrderStatus status;

  OrderModel({
    @required this.cardSum,
    @required this.dateTime,
    @required this.items,
    this.status = OrderStatus.Placed,
  });

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  factory OrderModel.fromSnapshot(Map<String, dynamic> map, String id) {
    map['id'] = id;
    return _$OrderModelFromJson(map);
  }

  @override
  String toString() {
    return 'OrderModel{items: $items, cardSum: $cardSum, dateTime: $dateTime, status: $status}';
  }
}
