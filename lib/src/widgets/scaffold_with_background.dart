import 'dart:ui';

import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class ScaffoldWithBackground extends StatelessWidget {
  final Widget child;
  final bool disableCardButton;
  final bool hideOrderButton;
  final String title;
  final String backgroundUrl;

  const ScaffoldWithBackground({
    Key key,
    @required this.child,
    this.disableCardButton = false,
    this.hideOrderButton = false,
    this.title,
    this.backgroundUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: _buildBackground() +
          <Widget>[
            Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                actions: <Widget>[
                  CardButton(
                    disableCardButton: disableCardButton,
                    hideOrderButton: hideOrderButton,
                  )
                ],
                bottom: title != null
                    ? AppBar(
                        title: Text('$title'),
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        automaticallyImplyLeading: false,
                      )
                    : null,
              ),
              body: Container(
                color: Colors.transparent,
                child: child,
              ),
            ),
          ],
    );
  }

  List<Widget> _buildBackground() {
    return backgroundUrl != null && backgroundUrl.isNotEmpty
        ? [
            Positioned.fill(
              child: Image.network(backgroundUrl, fit: BoxFit.cover),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 10.0,
                sigmaY: 10.0,
              ),
              child: Container(
                color: Colors.black.withOpacity(0.3),
              ),
            )
          ]
        : [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/background.png'),
                    fit: BoxFit.cover),
              ),
            )
          ];
  }
}
