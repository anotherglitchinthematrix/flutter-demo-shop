import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:course_008/App/pages/index.dart';
import 'package:course_008/App/providers/index.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthenticationProvider>.value(
          value: AuthenticationProvider(),
        ),
        ChangeNotifierProvider<ProductsProvider>.value(
          value: ProductsProvider(),
        ),
        ChangeNotifierProvider<FavoritesProvider>.value(
          value: FavoritesProvider(),
        ),
        ChangeNotifierProvider<CartProvider>.value(
          value: CartProvider(),
        ),
        ChangeNotifierProvider<OrderProvider>.value(
          value: OrderProvider(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'Inter',
          primarySwatch: Colors.blueGrey,
        ),
        home: AuthenticationPage(),
        routes: {
          ProductsPage.routeName: (context) => ProductsPage(),
          ProductPage.routeName: (context) => ProductPage(),
          CartPage.routeName: (context) => CartPage(),
          OrderPage.routeName: (context) => OrderPage(),
          ManagePage.routeName: (context) => ManagePage(),
          EditPage.routeName: (context) => EditPage(),
        },
      ),
    );
  }
}
