import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';
import '../screens/screens.dart';
import 'widgets.dart';

class ItemListTile extends StatelessWidget {
  ItemListTile();

  @override
  Widget build(BuildContext context) {
    final BaseItemModel item =
        Provider.of<BaseItemModel>(context, listen: false);

    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: new Offset(5.0, 5.0),
              blurRadius: 10.0,
            )
          ],
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white, width: 2)),
      child: Stack(
        children: <Widget>[
          ListTileImage(
            pictureUrl: item.pictureUrl,
            heroTag: item.id,
          ),
          _buildListTileCaption(item, context),
          _buildListTileFooter(item, context),
          _buildTapWidget(context, item),
        ],
      ),
    );
  }

  Material _buildTapWidget(BuildContext context, BaseItemModel item) {
    return Material(
      color: Colors.transparent,
      child: new InkWell(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => Provider<BaseItemModel>.value(
              value: item,
              child: ItemDetailScreen(),
            ),
          ),
        ),
      ),
    );
  }

  ListTileFooter _buildListTileFooter(
      BaseItemModel item, BuildContext context) {
    return ListTileFooter(
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
    );
  }

  ListTileCaption _buildListTileCaption(
      BaseItemModel item, BuildContext context) {
    return ListTileCaption(
      name: item.name,
      textAlign: TextAlign.start,
      textStyle: Theme.of(context).textTheme.subtitle,
    );
  }
}
