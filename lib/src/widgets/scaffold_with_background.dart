import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class ScaffoldWithBackground extends StatelessWidget {
  final Widget child;
  final bool disableCardButton;

  const ScaffoldWithBackground({
    Key key,
    @required this.child,
    this.disableCardButton = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.cover),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: <Widget>[CardButton(disableCardButton: disableCardButton)],
          ),
          body: Container(
            color: Colors.transparent,
            child: child,
          ),
        ),
      ],
    );
  }
}
