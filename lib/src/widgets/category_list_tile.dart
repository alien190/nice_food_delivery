import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:nice_food_delivery/src/helpers/fade_page_route.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';
import '../screens/screens.dart';
import 'widgets.dart';

class CategoryListTile extends StatefulWidget {
  CategoryListTile();

  @override
  _CategoryListTileState createState() => _CategoryListTileState();
}

class _CategoryListTileState extends State<CategoryListTile>
    with SingleTickerProviderStateMixin {
  final double _borderRadius = 15.0;
  AnimationController _controller;
  OverlayEntry _pictureEntry;
  OverlayEntry _blurEntry;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final item = Provider.of<CategoryItemModel>(context, listen: false);

    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: new Offset(5.0, 5.0),
              blurRadius: 10.0,
            )
          ],
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white, width: 2)),
      child: Stack(
        children: <Widget>[
          ListTileImage(
            pictureUrl: item.pictureUrl,
            borderRadius: _borderRadius,
          ),
          ListTileCaption(name: item.name),
          _buildTapWidget(context, item),
        ],
      ),
    );
  }

  Material _buildTapWidget(BuildContext context, CategoryItemModel item) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _onTap(item),
      ),
    );
  }

  void _onTap(CategoryItemModel item) async {
    //await _animatePictureForward(item.pictureUrl);
    final RenderBox renderBox = context.findRenderObject();
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final GlobalKey<ItemsScreenState> itemsScreenKey = GlobalKey();

    Navigator.of(context).push(
      FadePageRoute(
        builder: (ctx) => Provider<CategoryItemModel>.value(
          value: item,
          child: ItemsScreen(key: itemsScreenKey),
        ),
        borderRadius: _borderRadius,
        context: context,
        originalOffset: offset,
        originalSize: renderBox.size,
        url: item.pictureUrl,
      ),
    );
//    buildCompleter.future.then((value) {
//      _pictureEntry?.remove();
//      _blurEntry?.remove();
//    });
  }

  Future<void> _animatePictureForward(String url) async {
    final RenderBox renderBox = context.findRenderObject();
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final Size screenSize = MediaQuery.of(context).size;
    final double ratio = max(screenSize.height / renderBox.size.height,
        screenSize.width / renderBox.size.width);

    final double expandedHalfDiffHeight =
        (renderBox.size.height * ratio - screenSize.height) / 2;

    final double expandedHalfDiffWidth =
        (renderBox.size.width * ratio - screenSize.width) / 2;

    _pictureEntry = OverlayEntry(builder: (context) {
      return AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget child) {
          return Positioned(
            top: offset.dy * (1 - _controller.value) -
                expandedHalfDiffHeight * _controller.value,
            left: offset.dx * (1 - _controller.value) -
                expandedHalfDiffWidth * _controller.value,
            width: renderBox.size.width * (1 + (ratio - 1) * _controller.value),
            height:
                renderBox.size.height * (1 + (ratio - 1) * _controller.value),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                  _borderRadius * (1 - _controller.value)),
              child: child,
            ),
          );
        },
        child: Image.network(url, fit: BoxFit.cover),
      );
    });

    _blurEntry = OverlayEntry(builder: (context) {
      return AnimatedBuilder(
          animation: _controller,
          builder: (BuildContext context, Widget child) {
            return BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 10.0 * _controller.value,
                sigmaY: 10.0 * _controller.value,
              ),
              child: Container(
                color: Colors.black.withOpacity(_controller.value * 0.3),
              ),
            );
          });
    });

    Overlay.of(context).insertAll([_pictureEntry, _blurEntry]);
    //Overlay.of(context).insert(blurEntry);
    await _controller.forward();
  }

  Future<void> _animatePictureRevers() async {
    if (_controller.isCompleted &&
        _pictureEntry != null &&
        _blurEntry != null) {
      Overlay.of(context).insertAll([_pictureEntry, _blurEntry]);
      await _controller.reverse();
    }
    _pictureEntry?.remove();
    _pictureEntry = null;
    _blurEntry?.remove();
    _blurEntry = null;
  }
}
//
//final double expandedWidthDiffCoeff =
//    1 - (screenSize.width - renderBox.size.width * ratio) / 2;
//final double expandedHeightDiffCoeff =
//    1 - (screenSize.height - renderBox.size.height * ratio) / 2;
//
//OverlayEntry entry = OverlayEntry(builder: (context) {
//return AnimatedBuilder(
//animation: _controller,
//builder: (BuildContext context, Widget child) {
//return Positioned(
//top: offset.dy * (1 - _controller.value * expandedHeightDiffCoeff),
//left: offset.dx * (1 - _controller.value * expandedWidthDiffCoeff),
//width: renderBox.size.width * (1 + (ratio - 1) * _controller.value),
//
