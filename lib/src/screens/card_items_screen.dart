import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../blocs/blocs.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';
import '../screens/screens.dart';

class CardItemsScreen extends StatelessWidget {
  static final routeName = '/cardItems';

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBackground(
      child: _buildContent(context),
      disableCardButton: true,
      title: 'Your Cart',
    );
  }

  Widget _buildContent(BuildContext context) {
    final bloc = Provider.of<FoodBloc>(context);
    final ThemeData themeData = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: _buildList(bloc, themeData),
        ),
        _buildFooter(themeData, bloc),
      ],
    );
  }

  Widget _buildFooter(ThemeData themeData, FoodBloc bloc) {
    return StreamBuilder<CardSumModel>(
        stream: bloc.cardItemSum,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final CardSumModel cardSum = snapshot.data;

            return Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[200], width: 1),
                color: Theme.of(context).backgroundColor,
              ),
              width: double.infinity,
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: IntrinsicHeight(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: Container(
                        child: _buildTotalSection(themeData, cardSum),
                      )),
                      IntrinsicWidth(
                        child: _buildButtonSection(cardSum, themeData, bloc),
                      )
                    ],
                  ),
                ),
              ),
            );
          }
          return FittedBox();
        });
  }

  Widget _buildButtonSection(
      CardSumModel cardSum, ThemeData themeData, FoodBloc bloc) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'x${cardSum.quantity}',
                style: themeData.textTheme.title,
              ),
              Expanded(
                child: Container(),
              ),
              Text(
                '\$${cardSum.price.toStringAsFixed(2)}',
                style: themeData.textTheme.title,
              ),
            ],
          ),
        ),
        Builder(
          builder: (ctx) => FloatingActionButton.extended(
            onPressed: cardSum.isNotEmpty()
                ? () {
                    _placeOrder(bloc, ctx);
                  }
                : null,
            backgroundColor: cardSum.isNotEmpty()
                ? themeData.accentColor
                : themeData.backgroundColor,
            label: Text('PLACE ORDER'),
          ),
        ),
      ],
    );
  }

  void _placeOrder(FoodBloc bloc, BuildContext context) {
    bloc.placeOrder();
    Navigator.of(context).popAndPushNamed(OrdersScreen.routeName);
  }

  Widget _buildTotalSection(ThemeData themeData, CardSumModel cardSum) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Total',
          style: themeData.textTheme.subhead,
        ),
        Expanded(
          child: Container(),
        ),
        Text(
          'Proteins: ${cardSum.proteins.toStringAsFixed(1)}',
          style: themeData.textTheme.body1,
        ),
        Text(
          'Fats: ${cardSum.fats.toStringAsFixed(1)}',
          style: themeData.textTheme.body1,
        ),
        Text(
          'Carbohydrates: ${cardSum.carbohydrates.toStringAsFixed(1)}',
          style: themeData.textTheme.body1,
        ),
      ],
    );
  }

  Widget _buildList(FoodBloc bloc, ThemeData themeData) {
    return StreamBuilder(
      stream: bloc.fetchCardItems(),
      builder:
          (BuildContext context, AsyncSnapshot<List<CardItemModel>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.length == 0) {
            return Empty();
          }

          final List<CardItemModel> items = snapshot.data;
          return ListView.builder(
            itemCount: items.length,
            //padding: EdgeInsets.all(10),
            itemBuilder: (BuildContext context, int index) =>
                _buildItem(themeData, items[index], bloc),
          );
        }

        if (snapshot.hasError) {
          print(snapshot.error);
          return ErrorOccur();
        }

        return InProgress();
      },
    );
  }

  Widget _buildItem(ThemeData themeData, CardItemModel item, FoodBloc bloc) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        color: themeData.errorColor,
        child: Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: item.quantity == 1
              ? Icon(
                  Icons.delete,
                  color: Colors.white,
                )
              : Text(
                  '-1',
                  style: themeData.textTheme.body2,
                ),
        ),
      ),
      key: ValueKey(item.itemId),
      confirmDismiss: (_) => bloc.removeItemFromCard(item),
      child: Provider<CardItemModel>.value(
        value: item,
        child: CardListTile(),
      ),
    );
  }
}
