import 'package:json_annotation/json_annotation.dart';

import '../models/models.dart';

class JsonItemTypeConverter implements JsonConverter<ItemType, String> {
  const JsonItemTypeConverter();

  @override
  String toJson(ItemType itemType) {
    return ModelsFactory.itemTypeToString(itemType);
  }

  @override
  ItemType fromJson(String typeName) {
    return ModelsFactory.itemTypeFromString(typeName);
  }
}
