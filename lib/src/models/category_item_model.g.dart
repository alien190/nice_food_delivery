// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryItemModel _$CategoryItemModelFromJson(Map<String, dynamic> json) {
  return CategoryItemModel(
    id: json['id'] as String,
    name: json['name'] as String,
    pictureUrl: json['pictureUrl'] as String,
  );
}

Map<String, dynamic> _$CategoryItemModelToJson(CategoryItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'pictureUrl': instance.pictureUrl,
    };
