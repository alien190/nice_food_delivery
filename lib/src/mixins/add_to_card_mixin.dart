import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../blocs/blocs.dart';

mixin AddToCardMixin {
  void addItemToCard(BaseItemModel item, BuildContext context,) {
    final FoodBloc bloc = Provider.of<FoodBloc>(context);
    final ScaffoldState scaffoldState = Scaffold.of(context);
    bloc.addItemToCard(item);
    scaffoldState.hideCurrentSnackBar();
    scaffoldState.showSnackBar(
      SnackBar(
        content: Text('${item.name} added to cart'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  Future addItemToCardAsync(BaseItemModel item, BuildContext context,) async{
    final FoodBloc bloc = Provider.of<FoodBloc>(context);
    return bloc.addItemToCard(item);
  }

  void addItemToCardAnimated(BaseItemModel item, BuildContext context) {
    final FoodBloc bloc = Provider.of<FoodBloc>(context);
    final RenderBox renderBox = context.findRenderObject();
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final CardItemToAnimate cardItemToAnimate = CardItemToAnimate(
      item: item,
      offset: offset,
      size: renderBox.size,
    );
    bloc.addItemToCardWithAnimation(cardItemToAnimate);
  }
}
