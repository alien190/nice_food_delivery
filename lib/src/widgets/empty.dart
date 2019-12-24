import 'package:flutter/material.dart';

class Empty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('There is nothing yet',style: Theme.of(context).textTheme.body2,));
  }
}
