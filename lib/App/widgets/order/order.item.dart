import 'package:flutter/material.dart';
import 'package:course_008/App/providers/index.dart';

class OrderListItem extends StatelessWidget {
  OrderListItem(this.order);

  final OrderItem order;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(order.date.toString()),
      trailing: IconButton(
        icon: Icon(Icons.keyboard_arrow_down),
        onPressed: () {},
      ),
    );
  }
}
