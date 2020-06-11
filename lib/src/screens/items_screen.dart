import 'package:flutter/material.dart';
import 'package:nice_food_delivery/src/helpers/fade_page_route.dart';
import 'package:nice_food_delivery/src/widgets/animated_cart_sheet.dart';
import 'package:provider/provider.dart';

import '../blocs/blocs.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';

class ItemsScreen extends StatefulWidget {
  static final routeName = '/items';

  ItemsScreen({Key key}) : super(key: key);

  @override
  ItemsScreenState createState() => ItemsScreenState();
}

class ItemsScreenState extends State<ItemsScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _offsetAnimation = Tween<Offset>(
      begin: Offset(0, 1.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastOutSlowIn,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final CategoryItemModel category =
        Provider.of<CategoryItemModel>(context, listen: false);
    final FoodBloc bloc = Provider.of<FoodBloc>(context, listen: false);
    final Stream<List<BaseItemModel>> itemsStream =
        bloc.fetchCategoryItems(category.itemType, category.id);

    return WillPopScope(
      onWillPop: () async {
        await _controller.reverse();
        return true;
      },
      child: ScaffoldWithBackground(
        child: _buildContent(itemsStream),
        //child: Container(),
        title: category.name,
        backgroundUrl: category.pictureUrl,
      ),
    );
  }

  Widget _buildContent(Stream<List<BaseItemModel>> itemsStream) {
    return Stack(
      children: <Widget>[
        StreamBuilder(
          stream: itemsStream,
          builder: (BuildContext context,
              AsyncSnapshot<List<BaseItemModel>> snapshot) {
            if (snapshot.hasData) {
              if (_controller.isDismissed) _controller.forward();
              return _buildList(snapshot.data);
            }

            if (snapshot.hasError) {
              return ErrorOccur();
            }

            return InProgress();
          },
        ),
        AnimatedCartSheet(),
      ],
    );
  }

  Widget _buildList(List<BaseItemModel> data) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget child) {
          return SlideTransition(
            position: _offsetAnimation,
            child: GridView.builder(
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
            ),
          );
        });
  }
}
