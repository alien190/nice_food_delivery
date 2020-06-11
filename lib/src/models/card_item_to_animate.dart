import 'dart:ui';

import 'package:flutter/material.dart';

import 'base_item_model.dart';

class CardItemToAnimate {
  final BaseItemModel item;
  final Offset offset;
  final Size size;

  CardItemToAnimate({
    @required this.item,
    @required this.offset,
    @required this.size,
  });

  @override
  String toString() {
    return 'CardItemToAnimate{item: $item, offset: $offset, size: $size}';
  }
}
