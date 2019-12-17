import 'package:flutter/material.dart';

class ScaffoldWithBackground extends StatelessWidget {
  final Widget child;

  const ScaffoldWithBackground({
    Key key,
    @required this.child,
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
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.card_giftcard,
                ),
                color: Colors.white,
                onPressed: () {},
              )
            ],
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
