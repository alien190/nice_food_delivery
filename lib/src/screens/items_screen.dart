import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../blocs/blocs.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';

class ItemsScreen extends StatelessWidget {
  static final routeName = '/items';

  @override
  Widget build(BuildContext context) {
    final CategoryItemModel category =
        Provider.of<CategoryItemModel>(context, listen: false);
    final FoodBloc bloc = Provider.of<FoodBloc>(context, listen: false);
    final Stream<List<BaseItemModel>> itemsStream =
        bloc.fetchCategoryItems(category.itemType, category.id);

    return ScaffoldWithBackground(
      child: _buildContent(itemsStream),
    );
  }

  Widget _buildContent(Stream<List<BaseItemModel>> itemsStream) {
    return StreamBuilder(
      stream: itemsStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<BaseItemModel>> snapshot) {
        if (snapshot.hasData) {
          return _buildList(snapshot.data);
        }

        if (snapshot.hasError) {
          return ErrorOccur();
        }

        return InProgress();
      },
    );
  }

  Widget _buildList(List<BaseItemModel> data) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: data.length,
      padding: EdgeInsets.all(10),
      itemBuilder: (BuildContext context, int index) =>
          Provider<BaseItemModel>.value(
        value: data[index],
        child: ItemListTile(),
      ),
    );
  }
}
