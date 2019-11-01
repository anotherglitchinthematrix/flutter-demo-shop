import 'package:flutter/material.dart';
import 'package:course_008/App/providers/index.dart';
import 'package:course_008/App/widgets/index.dart';

class CartList extends StatelessWidget {
  CartList(this.cart);

  final CartProvider cart;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: ListView.builder(
          itemCount: cart.list.length,
          itemBuilder: (context, index) {
            return CartListItem(cart.list[index]);
          },
        ),
      ),
    );
  }
}
