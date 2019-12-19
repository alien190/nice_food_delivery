import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';
import '../screens/screens.dart';
import 'widgets.dart';

class CardListTile extends StatelessWidget {
  CardListTile();

  @override
  Widget build(BuildContext context) {
    final CardItemModel item =
        Provider.of<CardItemModel>(context, listen: false);

    final double width = MediaQuery.of(context).size.width;

    final double pictureSize = width * 0.3;

    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1),
          color: Theme.of(context).backgroundColor,
        ),
        child: Row(
          children: <Widget>[
            SizedBox.fromSize(
              size: Size(pictureSize, pictureSize),
              child: ListTileImage(pictureUrl: item.pictureUrl),
            ),
            Text('${item.name} ${item.quantity}')
          ],
        ));
  }
}
