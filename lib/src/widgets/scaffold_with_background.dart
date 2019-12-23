import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class ScaffoldWithBackground extends StatelessWidget {
  final Widget child;
  final bool disableCardButton;
  final bool hideOrderButton;
  final String title;

  const ScaffoldWithBackground({
    Key key,
    @required this.child,
    this.disableCardButton = false,
    this.hideOrderButton = false,
    this.title,
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
            actions: <Widget>[CardButton(disableCardButton: disableCardButton, hideOrderButton: hideOrderButton,)],
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
}
