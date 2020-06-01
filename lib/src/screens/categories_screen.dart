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
          return CategoryList(data: snapshot.data);
        }
        if (snapshot.hasError) {
          print(snapshot.error);
          return ErrorOccur();
        }
        return InProgress();
      },
    );
  }
}

class CategoryList extends StatefulWidget {
  final List<CategoryItemModel> data;

  CategoryList({
    Key key,
    @required List<CategoryItemModel> data,
  })  : assert(data != null),
        this.data = data,
        super(key: key);

  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList>
    with SingleTickerProviderStateMixin {
  Animation<Offset> _offsetAnimation;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    _offsetAnimation = Tween<Offset>(
      begin: Offset(0, 1.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastOutSlowIn,
      ),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: widget.data.length,
        padding: EdgeInsets.all(10),
        itemBuilder: (BuildContext context, int index) =>
            Provider<CategoryItemModel>.value(
          value: widget.data[index],
          child: CategoryListTile(),
        ),
      ),
    );
  }
}
