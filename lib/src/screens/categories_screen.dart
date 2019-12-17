import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../blocs/blocs.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<FoodBloc>(context);

    return ScaffoldWithBackground(
      child: _buildContent(bloc),
    );
  }

  Widget _buildContent(FoodBloc bloc) {
    return StreamBuilder(
      stream: bloc.fetchCategories(),
      builder: (BuildContext context,
          AsyncSnapshot<List<CategoryItemModel>> snapshot) {
        if (snapshot.hasData) {
          return _buildList(snapshot.data);
        }

        if (snapshot.hasError) {
          print(snapshot.error);
          return ErrorOccur();
        }

        return InProgress();
      },
    );
  }

  Widget _buildList(List<CategoryItemModel> data) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: data.length,
      padding: EdgeInsets.all(10),
      itemBuilder: (BuildContext context, int index) =>
          Provider<CategoryItemModel>.value(
        value: data[index],
        child: CategoryListTile(),
      ),
    );
  }
}

