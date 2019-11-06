import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:course_008/App/providers/index.dart';
import 'package:course_008/App/pages/index.dart';
import 'package:course_008/App/widgets/index.dart';

class ProductsPage extends StatefulWidget {
  static const routeName = 'products';

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  set isInitialized(bool v) {
    setState(() {
      _isInitialized = v;
    });
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool v) {
    setState(() {
      _isLoading = v;
    });
  }

  @override
  void didChangeDependencies() {
    if (!isInitialized) {
      isLoading = true;
      Provider.of<ProductsProvider>(context).fetch().then((_) => isLoading = false);
      Provider.of<FavoritesProvider>(context).fetch();

      isInitialized = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<ProductsProvider>(context, listen: false).fetch();

    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Shop App'),
        actions: <Widget>[
          Consumer<CartProvider>(
            builder: (context, cart, _) => BadgeButton(
              icon: Icons.shopping_cart,
              text: '${cart.count}',
              onPressed: () {
                Navigator.of(context).pushNamed(CartPage.routeName);
              },
            ),
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          ProductsGrid(),
          if (isLoading)
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
