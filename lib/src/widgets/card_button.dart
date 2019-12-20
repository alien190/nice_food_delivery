import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/screens.dart';
import '../models/models.dart';
import '../blocs/blocs.dart';

class CardButton extends StatelessWidget {
  const CardButton({
    Key key,
    this.disableCardButton = false,
  }) : super(key: key);

  final bool disableCardButton;

  @override
  Widget build(BuildContext context) {
    final FoodBloc foodBloc = Provider.of<FoodBloc>(context);

    return RaisedButton(
      disabledElevation: 0,
      disabledColor: Colors.transparent,
      color: Colors.transparent,
      elevation: 0,
      onPressed: disableCardButton
          ? null
          : () => Navigator.of(context).pushNamed(CardItemsScreen.routeName),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.card_giftcard,
            color: Colors.white,
          ),
          StreamBuilder<CardSumModel>(
              stream: foodBloc.cardItemSum,
              builder:
                  (BuildContext context, AsyncSnapshot<CardSumModel> snapshot) {
                if (snapshot.hasData) {
                  final CardSumModel cardSum = snapshot.data;
                  return Text(
                    'x${cardSum.quantity}   \$${cardSum.price.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.caption,
                  );
                } else {
                  return Container();
                }
              }),
          //IconButton(
          //icon:
        ],
      ),
    );
  }
}
