import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';

part 'card_item_model.g.dart';

@JsonSerializable()
class CardItemModel {
  final String id;
  final String itemId;
  final String name;
  final double price;
  final String pictureUrl;

  CardItemModel({
    @required this.id,
    @required this.itemId,
    @required this.name,
    @required this.price,
    @required this.pictureUrl,
  });

  factory CardItemModel.fromSnapshot(Map<String, dynamic> map, String id) {
    map['id'] = id;
    return _$CardItemModelFromJson(map);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = _$CardItemModelToJson(this);
    map.remove('id');
    return map;
  }
}
