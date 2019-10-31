import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:course_008/App/pages/index.dart';
import 'package:course_008/App/providers/index.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductsProvider>.value(
          value: ProductsProvider(),
        ),
        ChangeNotifierProvider<FavoritesProvider>.value(
          value: FavoritesProvider(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'Inter',
          primarySwatch: Colors.blueGrey,
        ),
        home: ProductsPage(),
        routes: {
          ProductPage.routeName: (context) => ProductPage(),
        },
      ),
    );
  }
}
