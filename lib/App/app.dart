import 'package:course_008/App/helpers/custom.route.dart';
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
          builder: (context, authenticationProvider, old) {
            return ProductsProvider(authenticationProvider.token, authenticationProvider.userId, list: old?.list);
          },
        ),
        ChangeNotifierProxyProvider<AuthenticationProvider, FavoritesProvider>(
          builder: (context, auth, pFavorite) => FavoritesProvider(auth.token, auth.userId),
        ),
        ChangeNotifierProvider<CartProvider>.value(
          value: CartProvider(),
        ),
        ChangeNotifierProxyProvider<AuthenticationProvider, OrderProvider>(
          builder: (context, auth, pOrder) => OrderProvider(auth.token, auth.userId),
        ),
      ],
      child: Consumer<AuthenticationProvider>(
        builder: (context, auth, _child) {
          return MaterialApp(
            theme: ThemeData(
              fontFamily: 'Inter',
              primarySwatch: Colors.blueGrey,
              pageTransitionsTheme: PageTransitionsTheme(builders: {
                TargetPlatform.android: CustomRouteTransitionBuilder(),
                TargetPlatform.iOS: CustomRouteTransitionBuilder(),
              }),
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
