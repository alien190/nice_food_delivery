import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_item_model.g.dart';

@JsonSerializable(nullable: false)
class CategoryItemModel {
  final String id;
  final String name;
  final String pictureUrl;

  CategoryItemModel(
      {@required this.id, @required this.name, @required this.pictureUrl});


  factory CategoryItemModel.fromSnapshot(Map<String, dynamic> map, String id) {
    map['id'] = id;
    return _$CategoryItemModelFromJson(map);
  }


}
