import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:course_008/App/providers/index.dart';
import 'package:course_008/App/widgets/index.dart';

class OrderListItem extends StatefulWidget {
  OrderListItem(this.order);

  final OrderItem order;

  @override
  _OrderListItemState createState() => _OrderListItemState();
}

class _OrderListItemState extends State<OrderListItem> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('\$ ${widget.order.total.toStringAsFixed(2)}'),
            subtitle: Text(DateFormat('MMMM dd, yyyy').format(widget.order.date)),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded)
            Container(
              // height: 100,
              constraints: BoxConstraints(
                maxHeight: 256,
              ),
              child: Scrollbar(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.order.cart.length,
                  itemBuilder: (context, index) {
                    return CartListItem(
                      widget.order.cart[index],
                      flat: true,
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
