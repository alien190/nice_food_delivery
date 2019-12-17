import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';
import 'widgets.dart';

class ItemListTile extends StatelessWidget {
  ItemListTile();

  @override
  Widget build(BuildContext context) {
    final item = Provider.of<BaseItemModel>(context, listen: false);

    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white, width: 2)),
      child: Stack(
        children: <Widget>[
          ListTileImage(pictureUrl: item.pictureUrl),
          ListTileCaption(
            name: item.name,
            textAlign: TextAlign.start,
            textStyle: Theme.of(context).textTheme.subtitle,
          ),
          ListTileFooter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  '\$${item.price}',
                  style: Theme.of(context).textTheme.subtitle,
                ),
                Icon(
                  Icons.add_circle,
                  color: Colors.white,
                )
              ],
            ),
          ),
          Material(
            color: Colors.transparent,
            child: new InkWell(
              onTap: () => {},
            ),
          ),
        ],
      ),
    );
  }
}
