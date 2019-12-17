import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';

import 'models.dart';
import '../common/common.dart';

part 'category_item_model.g.dart';

@JsonSerializable(nullable: false)
class CategoryItemModel {
  final String id;
  final String name;
  final String pictureUrl;
  @JsonItemTypeConverter()
  final ItemType itemType;

  CategoryItemModel(
      {@required this.id,
      @required this.name,
      @required this.pictureUrl,
      @required this.itemType});

  factory CategoryItemModel.fromSnapshot(Map<String, dynamic> map, String id) {
    map['id'] = id;
    return _$CategoryItemModelFromJson(map);
  }
}
