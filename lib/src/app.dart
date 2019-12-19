import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/screens.dart';
import 'blocs/blocs.dart';
import 'recources/resources.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _initProviders(
      child: MaterialApp(
        title: 'Nice Food Delivery',
        home: CategoriesScreen(),
        theme: _getThemeData(),
        routes: {
          ItemsScreen.routeName: (ctx) => ItemsScreen(),
          CardItemsScreen.routeName: (ctx) => CardItemsScreen(),
        },
      ),
    );
  }

  Widget _initProviders({@required Widget child}) {
    return MultiProvider(
      providers: [
        Provider<Repository>(
          create: (context) => FoodRepository(),
          dispose: (context, repository) => repository.dispose(),
        ),
        ProxyProvider<Repository, FoodBloc>(
          update: (_, repository, __) => FoodBloc(repository),
          dispose: (context, bloc) => bloc.dispose(),
        ),
      ],
      child: child,
    );
  }

  ThemeData _getThemeData() {
    return ThemeData(
      primarySwatch: Colors.brown,
      backgroundColor: Colors.grey[400],
      accentColor: Colors.green[400],
      textTheme: TextTheme(
        caption: TextStyle(color: Colors.white, fontSize: 18),
        subtitle: TextStyle(color: Colors.white, fontSize: 16),
        title: TextStyle(color: Colors.black87, fontSize: 22),
        body2: TextStyle(color: Colors.white, fontSize: 22),
        body1: TextStyle(color: Colors.black87),
        subhead: TextStyle(color: Colors.grey[800], fontSize: 18),
      ),
    );
  }
}
