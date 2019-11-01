import 'package:flutter/material.dart';
import 'package:course_008/App/providers/index.dart';

class CartListItem extends StatelessWidget {
  CartListItem(this.item);

  final CartItem item;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Text(item.quantity.toString()),
      ),
    );
  }
}
