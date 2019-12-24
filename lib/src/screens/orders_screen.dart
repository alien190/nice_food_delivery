import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/widgets.dart';
import '../blocs/blocs.dart';
import '../models/models.dart';

class OrdersScreen extends StatelessWidget {
  static final String routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBackground(
      child: _buildContent(context),
      title: 'Your orders',
      hideOrderButton: true,
    );
  }

  Widget _buildContent(BuildContext context) {
    final bloc = Provider.of<FoodBloc>(context);

    return StreamBuilder<List<OrderModel>>(
      stream: bloc.fetchOrders(),
      builder: (context, AsyncSnapshot<List<OrderModel>> snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data);
          if (snapshot.data.length == 0) {
            return Empty();
          } else {
            return _buildList(snapshot.data);
          }
        }
        if (snapshot.hasError) {
          print('${snapshot.error}');
          return ErrorOccur();
        }
        return InProgress();
      },
    );
  }

  Widget _buildList(List<OrderModel> orders) {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (BuildContext context, int index) =>
          Provider<OrderModel>.value(
        value: orders[index],
        child: OrderListTile(),
      ),
    );
  }
}
