import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:course_008/App/providers/index.dart';
import 'package:course_008/App/pages/index.dart';
import 'package:course_008/App/widgets/index.dart';

class ProductsPage extends StatelessWidget {
  static const routeName = 'products';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop App'),
        actions: <Widget>[
          Consumer<CartProvider>(
            builder: (context, cart, _) => BadgeButton(
              icon: Icons.shopping_cart,
              text: cart.count,
              onPressed: () {
                Navigator.of(context).pushNamed(CartPage.routeName);
              },
            ),
          ),
        ],
      ),
      body: ProductsGrid(),
    );
  }
}
