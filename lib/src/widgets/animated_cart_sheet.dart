import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nice_food_delivery/src/blocs/blocs.dart';
import 'package:nice_food_delivery/src/mixins/add_to_card_mixin.dart';
import 'package:nice_food_delivery/src/models/base_item_model.dart';
import 'package:nice_food_delivery/src/models/card_item_model.dart';
import 'package:nice_food_delivery/src/models/card_item_to_animate.dart';
import 'package:provider/provider.dart';

class AnimatedCartSheet extends StatefulWidget {
  AnimatedCartSheet({Key key}) : super(key: key);

  @override
  AnimatedCartSheetState createState() => AnimatedCartSheetState();
}

class AnimatedCartSheetState extends State<AnimatedCartSheet>
    with SingleTickerProviderStateMixin, AddToCardMixin {
  AnimationController _animationController;
  final double _borderRadius = 15.0;
  final double _itemsPadding = 5.0;
  final double _minSheetSize = 0.2;
  List<StreamSubscription> _subscriptions = [];
  List<CardItemModel> _cardItems;
  FoodBloc _bloc;
  OverlayEntry _pictureEntry;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 500,
      ),
    );
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_subscriptions.isEmpty) {
      _bloc = Provider.of<FoodBloc>(context);
      _subscriptions.add(_bloc.cardItemToAnimate.listen(_onAddItemToCart));
      _subscriptions.add(_bloc.fetchCardItems().listen(_onCardItemsListener));
    }
  }

  @override
  void didUpdateWidget(AnimatedCartSheet oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  void _onCardItemsListener(List<CardItemModel> cardItems) {
    _cardItems = cardItems;
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      builder: (BuildContext ctx, ScrollController controller) {
        return Container(
          color: Colors.white.withOpacity(0.3),
          child: StreamBuilder(
            stream: _bloc.fetchCardItems(),
            builder: (BuildContext ctx,
                AsyncSnapshot<List<CardItemModel>> snapshot) {
              if (snapshot.hasData && snapshot.data.isNotEmpty) {
                if (_pictureEntry != null) {
                  _pictureEntry.remove();
                  _pictureEntry = null;
                }
                final Widget items = _buildCartItems(snapshot.data);
                return items;
              }
              return Container();
            },
          ),
        );
      },
      minChildSize: _minSheetSize,
      initialChildSize: _minSheetSize,
    );
  }

  Widget _buildCartItems(List<CardItemModel> itemModelList) {
    final RenderBox renderBox = context.findRenderObject();
    final double itemSize =
        renderBox.size.height * _minSheetSize - _itemsPadding * 2;

    return AnimatedBuilder(
      animation: _animationController,
      builder: (BuildContext ctx, Widget child) {
        final double animationValue =
            _pictureEntry != null ? _animationController.value : 0;

        final int itemCount =
            renderBox.size.width ~/ itemSize - 1 - animationValue.toInt();
        List<Widget> items = [];

        for (CardItemModel itemModel in itemModelList) {
          Widget item = Padding(
            padding: EdgeInsets.only(
              top: _itemsPadding,
              bottom: _itemsPadding,
              left: _itemsPadding,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(_borderRadius),
              child: Image.network(itemModel.pictureUrl, fit: BoxFit.cover),
            ),
          );
          items.add(item);

          if (items.length >= itemCount) break;
        }
        return _buildShaderMask(
          Stack(
            children: <Widget>[
              Positioned(
                  top: 0,
                  bottom: 0,
                  right: 0,
                  left: animationValue * itemSize,
                  child: Row(children: items)),
            ],
          ),
        );
      },
    );
  }

  ShaderMask _buildShaderMask(Widget item) {
    return ShaderMask(
      shaderCallback: (rect) {
        return LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Colors.black, Colors.transparent],
        ).createShader(
            Rect.fromLTRB(rect.width * 0.5, 0, rect.width * 0.7, rect.height));
      },
      blendMode: BlendMode.dstIn,
      child: item,
    );
  }

  @override
  void dispose() {
    _subscriptions?.forEach((s) => s?.cancel());
    super.dispose();
  }

  void _onAddItemToCart(CardItemToAnimate cardItemToAnimate) async {
    final RenderBox renderBox = context.findRenderObject();
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final double dyOffset =
        offset.dy + renderBox.size.height * (1 - _minSheetSize);
    final double itemSize =
        renderBox.size.height * _minSheetSize - _itemsPadding * 2;
    print(itemSize);

    _animationController.reset();
    _pictureEntry = OverlayEntry(builder: (context) {
      return AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, Widget child) {
          return Positioned(
            top:
                cardItemToAnimate.offset.dy * (1 - _animationController.value) +
                    (dyOffset + _itemsPadding) * _animationController.value,
            left:
                cardItemToAnimate.offset.dx * (1 - _animationController.value) +
                    (offset.dx + _itemsPadding) * _animationController.value,
            width: cardItemToAnimate.size.width *
                    (1 - _animationController.value) +
                itemSize * _animationController.value,
            height: cardItemToAnimate.size.height *
                    (1 - _animationController.value) +
                itemSize * _animationController.value,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(_borderRadius),
              child: child,
            ),
          );
        },
        child:
            Image.network(cardItemToAnimate.item.pictureUrl, fit: BoxFit.cover),
      );
    });

    Overlay.of(context).insert(_pictureEntry);
    await _animationController.forward();
    await addItemToCardAsync(cardItemToAnimate.item, context);
  }
}
