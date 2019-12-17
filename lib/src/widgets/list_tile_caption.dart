import 'package:flutter/material.dart';

class ListTileCaption extends StatelessWidget {
  const ListTileCaption({
    Key key,
    @required this.name,
    this.textAlign,
    this.textStyle,
  }) : super(key: key);

  final String name;
  final TextStyle textStyle;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
          child: Container(
            height: 80,
            width: double.infinity,
            foregroundDecoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black, Colors.transparent],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: double.infinity,
            child: Text(
              name,
              textAlign: textAlign ?? TextAlign.center,
              style: textStyle ?? Theme.of(context).textTheme.caption,
            ),
          ),
        ),
      ],
    );
  }
}
