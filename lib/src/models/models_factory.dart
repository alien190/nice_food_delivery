import 'models.dart';

enum ItemType {
  sushi,
  pizza,
}

class ModelsFactory {
  static final _itemCollectionNames = <ItemType, String>{
    ItemType.sushi: 'sushi',
    ItemType.pizza: 'pizza'
  };

  static BaseItemModel fromSnapshot(
      Map<String, dynamic> map, String id, ItemType itemType) {
    map['id'] = id;

    switch (itemType) {
      case ItemType.sushi:
        return SushiItemModel.fromSnapshot(map, id);
      case ItemType.pizza:
        return PizzaItemModel.fromSnapshot(map, id);
    }

    return null;
  }

  static ItemType itemTypeFromString(String typeName) {
    ItemType type;
    _itemCollectionNames.forEach((k, v) {
      if (v == typeName.toLowerCase()) {
        type = k;
      }
    });
    return type;
  }

  static String itemTypeToString(ItemType itemType) {
    return _itemCollectionNames[itemType];
  }
}
