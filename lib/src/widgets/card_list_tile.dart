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
    final double pictureSize = width * 0.2;
    final ThemeData themeData = Theme.of(context);

    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1),
          color: Theme.of(context).backgroundColor,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            SizedBox.fromSize(
              size: Size(pictureSize, pictureSize),
              child: ListTileImage(pictureUrl: item.pictureUrl),
            ),
            Expanded(
              child: Container(
                //height: pictureSize,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '${item.name}',
                        style: themeData.textTheme.headline,
                        maxLines: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Text(
                            'x${item.quantity}',
                            style: themeData.textTheme.title,
                          ),
                          Text(
                            '\$${item.price.toStringAsFixed(2)}',
                            style: themeData.textTheme.title,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
