import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';
import '../screens/screens.dart';
import 'widgets.dart';

class CategoryListTile extends StatelessWidget {
  CategoryListTile();

  @override
  Widget build(BuildContext context) {
    final item = Provider.of<CategoryItemModel>(context, listen: false);

    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white, width: 2)),
      child: Stack(
        children: <Widget>[
          ListTileImage(pictureUrl: item.pictureUrl),
          ListTileCaption(name: item.name),
          Material(
            color: Colors.transparent,
            child: new InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => Provider<CategoryItemModel>.value(
                    value: item,
                    child: ItemsScreen(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
