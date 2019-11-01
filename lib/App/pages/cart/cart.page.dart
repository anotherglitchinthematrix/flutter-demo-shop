import 'package:course_008/App/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:course_008/App/providers/index.dart';

class CartPage extends StatelessWidget {
  static const routeName = 'cart';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Consumer<CartProvider>(
        builder: (context, cart, _) => Column(
          children: <Widget>[
            Card(
              margin: EdgeInsets.all(8),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  children: <Widget>[],
                ),
              ),
            ),
            CartList(cart),
          ],
        ),
      ),
    );
  }
}
