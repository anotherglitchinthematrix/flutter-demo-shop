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
        ChangeNotifierProxyProvider<AuthenticationProvider, ProductsProvider>(
          builder: (context, authenticationProvider, _) {
            return ProductsProvider(authenticationProvider.token);
          },
        ),
        ChangeNotifierProxyProvider<AuthenticationProvider, FavoritesProvider>(
          builder: (context, auth, pFavorite) => FavoritesProvider(auth.token),
        ),
        ChangeNotifierProvider<CartProvider>.value(
          value: CartProvider(),
        ),
        ChangeNotifierProxyProvider<AuthenticationProvider, OrderProvider>(
          builder: (context, auth, pOrder) => OrderProvider(auth.token),
        ),
      ],
      child: Consumer<AuthenticationProvider>(
        builder: (context, auth, _child) {
          return MaterialApp(
            theme: ThemeData(
              fontFamily: 'Inter',
              primarySwatch: Colors.blueGrey,
            ),
            home: auth.isAuthenticated ? ProductsPage() : AuthenticationPage(),
            routes: {
              ProductsPage.routeName: (context) => ProductsPage(),
              ProductPage.routeName: (context) => ProductPage(),
              CartPage.routeName: (context) => CartPage(),
              OrderPage.routeName: (context) => OrderPage(),
              ManagePage.routeName: (context) => ManagePage(),
              EditPage.routeName: (context) => EditPage(),
            },
          );
        },
      ),
    );
  }
}
