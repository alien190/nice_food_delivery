import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class FadePageRoute<T> extends MaterialPageRoute<T> {
  final Offset originalOffset;
  final Size originalSize;
  final String url;
  final double borderRadius;
  final VoidCallback onTransitionAnimationEnd;
  double expandedHalfDiffHeight;
  double expandedHalfDiffWidth;
  double ratio;
  bool _isChildShown;

  FadePageRoute(
      {WidgetBuilder builder,
      RouteSettings settings,
      @required this.originalOffset,
      @required this.originalSize,
      @required BuildContext context,
      @required this.url,
      @required this.borderRadius,
      this.onTransitionAnimationEnd})
      : super(builder: builder, settings: settings) {
    final Size screenSize = MediaQuery.of(context).size;
    ratio = max(screenSize.height / originalSize.height,
        screenSize.width / originalSize.width);

    expandedHalfDiffHeight =
        (originalSize.height * ratio - screenSize.height) / 2;

    expandedHalfDiffWidth = (originalSize.width * ratio - screenSize.width) / 2;
    _isChildShown = false;
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    if (!animation.isCompleted) {
      return Stack(
        children: <Widget>[
          Positioned(
            top: originalOffset.dy * (1 - animation.value) -
                expandedHalfDiffHeight * animation.value,
            left: originalOffset.dx * (1 - animation.value) -
                expandedHalfDiffWidth * animation.value,
            width: originalSize.width * (1 + (ratio - 1) * animation.value),
            height: originalSize.height * (1 + (ratio - 1) * animation.value),
            child: ClipRRect(
              borderRadius:
                  BorderRadius.circular(borderRadius * (1 - animation.value)),
              child: Image.network(url, fit: BoxFit.cover),
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 10.0 * animation.value,
                sigmaY: 10.0 * animation.value,
              ),
              child: Container(
                color: Colors.black.withOpacity(animation.value * 0.3),
              ),
            ),
          ),
        ],
      );
    } else {
      if (!_isChildShown) {
        if (onTransitionAnimationEnd != null) onTransitionAnimationEnd();
        print('end');
        _isChildShown = true;
      }
      return child;
    }
  }
}
