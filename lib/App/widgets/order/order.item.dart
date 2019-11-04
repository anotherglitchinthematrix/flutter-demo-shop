import 'package:course_008/App/pages/index.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:course_008/App/providers/index.dart';

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
      elevation: 2,
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
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withAlpha(18),
                border: Border(
                  top: BorderSide(
                    width: 1,
                    color: Theme.of(context).primaryColor.withAlpha(36),
                  ),
                ),
              ),

              constraints: BoxConstraints(
                maxHeight: 256,
              ),
              child: Scrollbar(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.order.cart.length,
                  itemBuilder: (context, index) {
                    var item = widget.order.cart[index];
                    return GestureDetector(
                      onTap: () => Navigator.of(context).pushNamed(
                        ProductPage.routeName,
                        arguments: ProductPageArgument(product: item.product),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(8),
                        child: Row(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: Container(
                                width: 36,
                                height: 36,
                                child: Image.network(item.product.imageURL, fit: BoxFit.cover),
                              ),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    item.product.title,
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColorDark,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    item.product.description,
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColorDark.withAlpha(128),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      'Price',
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        // fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      '\$ ${(item.quantity * item.product.price).toStringAsFixed(2)}',
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColorDark,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'Qty',
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      '${item.quantity}',
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColorDark,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                    // return CartListItem(
                    //   widget.order.cart[index],
                    //   flat: true,
                    // );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
