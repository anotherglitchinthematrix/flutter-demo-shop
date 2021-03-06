import 'package:course_008/App/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:course_008/App/providers/order/order.provider.dart';

class OrderList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(
      builder: (context, orders, _) {
        var _reversed = orders.list.reversed.toList();
        return ListView.builder(
          itemCount: orders.list.length,
          itemBuilder: (context, index) {
            return OrderListItem(_reversed[index]);
          },
        );
      },
    );
  }
}
