import 'package:flutter/material.dart';
import 'package:course_008/App/providers/index.dart';
import 'package:intl/intl.dart';

class OrderListItem extends StatelessWidget {
  OrderListItem(this.order);

  final OrderItem order;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(DateFormat('MMMM dd, yyyy').format(order.date)),
      trailing: IconButton(
        icon: Icon(Icons.keyboard_arrow_down),
        onPressed: () {},
      ),
    );
  }
}
