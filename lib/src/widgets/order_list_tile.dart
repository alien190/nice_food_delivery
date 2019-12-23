import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import 'widgets.dart';

class OrderListTile extends StatefulWidget {
  @override
  _OrderListTileState createState() => _OrderListTileState();
}

class _OrderListTileState extends State<OrderListTile> {
  final _dateFormat = DateFormat("dd MMMM yyyy HH:mm");
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final OrderModel order = Provider.of<OrderModel>(context, listen: false);
    final DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(order.dateTime * 1000);
    final ThemeData themeData = Theme.of(context);

    final double width = MediaQuery.of(context).size.width;
    final double pictureSize = width * 0.2;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        color: themeData.backgroundColor,
      ),
      child: Column(
        children: <Widget>[
          IntrinsicHeight(
            child: Stack(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    SizedBox.fromSize(
                      size: Size(pictureSize, pictureSize),
                      child: _getLeading(order, pictureSize),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              '${_dateFormat.format(dateTime)}',
                              style: themeData.textTheme.body1,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Text(
                                  'x${order.cardSum.quantity}',
                                  style: themeData.textTheme.title,
                                ),
                                Text(
                                  '\$${order.cardSum.price.toStringAsFixed(2)}',
                                  style: themeData.textTheme.title,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: themeData.accentColor,
                    onTap: () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                  ),
                )
              ],
            ),
          ),
          isExpanded ? _getDetails(order, pictureSize, themeData) : Container(),
        ],
      ),
    );
  }

  Widget _getLeading(OrderModel order, double size) {
    Widget def;

    switch (order.status) {
      case OrderStatus.Placed:
        {
          def = Image.asset('assets/images/new_tag.png', color: Colors.white);
          break;
        }
      case OrderStatus.InProgress:
        {
          def = Image.asset('assets/images/delivery.png', color: Colors.white);
          break;
        }
      case OrderStatus.Done:
        {
          def = Image.asset('assets/images/done.png', color: Colors.white);
          break;
        }
    }

    if (order.items.isNotEmpty) {
      return Stack(
        children: <Widget>[
          ListTileImage(pictureUrl: order.items[0].pictureUrl),
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black, Colors.transparent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              right: size * 0.5,
              bottom: size * 0.5,
              top: size * 0.05,
              left: size * 0.05,
            ),
            child: def,
          )
        ],
      );
    }

    return def;
  }

  Widget _getDetails(
      OrderModel order, double pictureSize, ThemeData themeData) {
    final List<Widget> widgets = order.items
        .map((CardItemModel item) => Provider<CardItemModel>.value(
              value: item,
              child: CardListTile(),
            ))
        .toList();

    return Padding(
      padding: EdgeInsets.only(
        top: 20,
        bottom: 20,
        left: pictureSize * 0.5,
        right: pictureSize * 0.5,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order items',
            style: themeData.textTheme.body1,
          ),
          Column(
            children: widgets,
          ),
          SizedBox.fromSize(
            size: Size.fromHeight(12),
          ),
          order.status == OrderStatus.InProgress
              ? Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  child: FloatingActionButton.extended(
                      onPressed: () {},
                      label: Text('View current order location')),
                )
              : Container(),
        ],
      ),
    );
  }
}
