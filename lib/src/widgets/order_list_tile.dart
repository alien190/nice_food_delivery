import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';

class OrderListTile extends StatelessWidget {
  final _dateFormat = DateFormat("dd MMMM yyyy HH:mm");

  @override
  Widget build(BuildContext context) {
    final OrderModel order = Provider.of<OrderModel>(context, listen: false);
    final DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(order.dateTime * 1000);
    final ThemeData themeData = Theme.of(context);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        color: themeData.backgroundColor,
      ),
      child: IntrinsicHeight(
        child: Stack(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: FittedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: _getLeading(order),
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Column(
                    children: <Widget>[
                      Text('${_dateFormat.format(dateTime)}'),
                      Text('${_dateFormat.format(dateTime)}'),
                    ],
                  ),
                )
              ],
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: themeData.accentColor,
                onTap: () {},
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _getLeading(OrderModel order) {
    final Widget def = Image.asset('assets/images/new_tag.png',);

    switch (order.status) {
      case OrderStatus.Placed:
        return def;
      case OrderStatus.InProgress:
        return Image.asset('assets/images/inprogress.png');
      case OrderStatus.Done:
        return Image.asset('assets/images/done.png');
    }
    return def;
  }
}
