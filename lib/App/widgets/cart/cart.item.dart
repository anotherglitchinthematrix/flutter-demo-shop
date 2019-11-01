import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:course_008/App/providers/index.dart';

class CartListItem extends StatelessWidget {
  CartListItem(this.item);

  final CartItem item;

  @override
  Widget build(BuildContext context) {
    var product = item.product;
    return Card(
      // color: Colors.blue,
      margin: EdgeInsets.only(bottom: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Dismissible(
          key: ValueKey(item.id),
          background: Container(
            alignment: Alignment.centerRight,
            color: Colors.red,
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
          ),
          direction: DismissDirection.endToStart,
          onDismissed: (_) {
            Provider.of<CartProvider>(context).removeFromCart(item);
          },
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
            // dense: true,
            leading: Image.network(
              product.imageURL,
              fit: BoxFit.cover,
            ),
            title: Text(product.title),
            subtitle: Text(product.description),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _CardColumn(
                  title: 'Price',
                  subtitle: '\$ ${(item.quantity * product.price).toStringAsFixed(2)}',
                  alignment: CrossAxisAlignment.end,
                ),
                _CardColumn(
                  title: 'Qty',
                  subtitle: '${item.quantity}',
                  alignment: CrossAxisAlignment.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CardColumn extends StatelessWidget {
  const _CardColumn({
    @required this.title,
    @required this.subtitle,
    this.alignment = CrossAxisAlignment.start,
  });

  final String title;
  final String subtitle;
  final CrossAxisAlignment alignment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: alignment,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
