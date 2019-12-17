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
        routes: {ItemsScreen.routeName: (ctx) => ItemsScreen()},
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
        textTheme:
            TextTheme(caption: TextStyle(color: Colors.white, fontSize: 18),subtitle: TextStyle(color: Colors.white, fontSize: 16)));
  }
}
