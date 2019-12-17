import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class ListTileImage extends StatelessWidget {
  const ListTileImage({
    Key key,
    @required this.pictureUrl,
  }) : super(key: key);

  final String pictureUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              'assets/images/stub_item.jpg',
              fit: BoxFit.cover,
            ),
          ),
          (pictureUrl != null && pictureUrl.isNotEmpty)
              ? Container(
            width: double.infinity,
            height: double.infinity,
            child: FadeInImage.memoryNetwork(
              fadeInDuration: Duration(milliseconds: 300),
              placeholder: kTransparentImage,
              image: pictureUrl,
              fit: BoxFit.cover,
            ),
          )
              : FittedBox(),
        ],
      ),
    );
  }
}
