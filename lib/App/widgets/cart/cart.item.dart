import 'package:course_008/App/pages/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:course_008/App/providers/index.dart';

class CartListItem extends StatelessWidget {
  CartListItem(this.item, {this.flat = false});

  final CartItem item;
  final flat;

  @override
  Widget build(BuildContext context) {
    var product = item.product;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          ProductPage.routeName,
          arguments: ProductPageArgument(
            product: item.product,
          ),
        );
      },
      child: Card(
        // color: Colors.blue,
        // elevation: 0,
        elevation: flat ? 0 : 2,
        margin: EdgeInsets.only(bottom: 8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Dismissible(
            key: ValueKey(item.id),
            movementDuration: Duration(milliseconds: 200),
            resizeDuration: Duration(milliseconds: 200),
            background: Container(
              alignment: Alignment.centerRight,
              color: Colors.red.withAlpha(24),
              child: Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ),
            direction: DismissDirection.endToStart,
            onDismissed: (_) {
              Provider.of<CartProvider>(context).remove(item);
            },
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
              // dense: true,
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Container(
                  width: 48,
                  child: Image.network(
                    product.imageURL,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: Text(
                product.title,
                style: TextStyle(
                  color: Theme.of(context).primaryColorDark,
                  fontWeight: FontWeight.w500,
                ),
              ),
              subtitle: Text(
                product.description,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
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
              color: Theme.of(context).primaryColor,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              color: Theme.of(context).primaryColorDark,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
