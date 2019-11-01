import 'package:course_008/App/providers/index.dart';
import 'package:flutter/material.dart';

class CartListItem extends StatelessWidget {
  CartListItem(this.item);

  final CartItem item;

  @override
  Widget build(BuildContext context) {
    return Text(item.quantity.toString());
  }
}
