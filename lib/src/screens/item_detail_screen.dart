import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../blocs/blocs.dart';
import '../widgets/widgets.dart';
import '../mixins/mixins.dart';

class ItemDetailScreen extends StatelessWidget with AddToCardMixin {
  @override
  Widget build(BuildContext context) {
    final BaseItemModel item =
        Provider.of<BaseItemModel>(context, listen: false);
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final double height = mediaQueryData.size.height * 0.5;
    final ThemeData themeData = Theme.of(context);
    final FoodBloc foodBloc = Provider.of<FoodBloc>(context, listen: false);

    return Scaffold(
      backgroundColor: themeData.backgroundColor,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            actions: <Widget>[CardButton()],
            expandedHeight: height,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: _getPicture(item, height),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [_getDetails(themeData, item, foodBloc, context)],
            ),
          ),
        ],
      ),
    );
  }

  Widget _getPicture(BaseItemModel item, double height) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.topLeft,
      child: Stack(
        alignment: Alignment.topLeft,
        children: <Widget>[
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Hero(
              tag: item.id,
              child: Image.network(
                item.pictureUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: height * 0.5,
            alignment: Alignment.topLeft,
            foregroundDecoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black, Colors.transparent],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getDetails(ThemeData themeData, BaseItemModel item, FoodBloc foodBloc,
      BuildContext context) {
    final String ingredients = _getIngredients(item);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            item.name,
            style: themeData.textTheme.title,
          ),
          SizedBox(height: 20),
          _buildEnergyAndPrice(item, themeData, foodBloc),
          SizedBox(height: 20),
          Text(
            ingredients,
            style: themeData.textTheme.body1,
          ),
          SizedBox(height: 20),
          Container(
            width: double.infinity,
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: <Widget>[
                Text('Proteins: ${item.proteins}',
                    style: themeData.textTheme.body1),
                Text('Fats: ${item.fats}', style: themeData.textTheme.body1),
                Text('Carbohydrates: ${item.carbohydrates}',
                    style: themeData.textTheme.body1),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getIngredients(BaseItemModel item) {
    String ingredients = '';
    item.ingredients.forEach((item) {
      if (ingredients.isNotEmpty) {
        ingredients = '$ingredients, $item';
      } else {
        ingredients = '$item';
      }
    });

    if (ingredients.isNotEmpty) {
      ingredients =
          '${ingredients.substring(0, 1).toUpperCase()}${ingredients.substring(1).toLowerCase()}.';
    }
    return ingredients;
  }

  Widget _buildEnergyAndPrice(
      BaseItemModel item, ThemeData themeData, FoodBloc foodBloc) {
    return Container(
      width: double.infinity,
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildWeigh(item, themeData),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(Icons.fastfood),
                  SizedBox(width: 5),
                  Text(
                    '${item.energy} kcal',
                    style: themeData.textTheme.body1,
                  ),
                ],
              ),
            ],
          ),
          Text('\$${item.price}', style: themeData.textTheme.title),
          _buildAddButton(item, themeData, foodBloc),
        ],
      ),
    );
  }

  Widget _buildAddButton(
      BaseItemModel item, ThemeData themeData, FoodBloc foodBloc) {
    return Builder(
      builder: (context) => FloatingActionButton.extended(
        onPressed: () => addItemToCard(item, context),
        label: Text('ADD'),
        icon: Icon(Icons.add_circle),
      ),
    );
  }

  Widget _buildWeigh(BaseItemModel item, ThemeData themeData) {
    if (item is SushiItemModel) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(Icons.line_weight),
            SizedBox(width: 5),
            Text(
              'x${item.quantity} ${item.weigh}g',
              style: themeData.textTheme.body1,
            ),
          ],
        ),
      );
    }
    return FittedBox();
  }
}
