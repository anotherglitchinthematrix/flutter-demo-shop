// import 'package:course_008/App/pages/order/order.page.dart';
import 'package:course_008/App/pages/index.dart';
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
              // color: Theme.of(context).primaryColorLight,
              margin: EdgeInsets.all(8),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    OrderButton(cart),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          'Total',
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).primaryColorDark,
                          ),
                        ),
                        Text(
                          '\$ ${cart.totalAmount.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: Theme.of(context).primaryColorDark,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            cart.isEmpty ? _EmptyState() : CartList(cart),
          ],
        ),
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton(this.cart, {Key key}) : super(key: key);

  final CartProvider cart;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  set isLoading(bool v) {
    setState(() {
      _isLoading = v;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlatButton.icon(
      color: Theme.of(context).primaryColor.withAlpha(48),
      textColor: Theme.of(context).primaryColorDark,
      splashColor: Theme.of(context).primaryColor.withAlpha(96),
      highlightColor: Colors.transparent,
      onPressed: (widget.cart.list.isEmpty || isLoading)
          ? null
          : () async {
              isLoading = true;
              await Provider.of<OrderProvider>(context, listen: false).place(widget.cart.list, widget.cart.totalAmount);
              isLoading = false;
              widget.cart.clear();
              Navigator.pushReplacementNamed(context, OrderPage.routeName);

              // Place the order.
              // var isCompleted = Provider.of<OrderProvider>(context, listen: false).order(
              //   cart.list,
              //   cart.totalAmount,
              // );
              // if (isCompleted) {
              //   cart.clear();
              // }
            },
      icon: isLoading
          ? Container(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                strokeWidth: 3,
              ))
          : Icon(Icons.payment),
      label: Text(
        'Order Now',
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.shopping_cart,
            size: 48,
            color: Theme.of(context).primaryColorLight,
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            'Cart is empty',
            style: TextStyle(
              fontSize: 18,
              color: Theme.of(context).primaryColorLight,
            ),
          ),
        ],
      ),
    );
  }
}
