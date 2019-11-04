import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:course_008/App/models/index.dart';
import 'package:course_008/App/providers/index.dart';
import 'package:course_008/App/pages/index.dart';

class ProductGridItem extends StatelessWidget {
  ProductGridItem(this.product);

  final Product product;

  @override
  Widget build(BuildContext context) {
    /// Radius for decoration and clipRRect.
    var radius = BorderRadius.circular(8);

    /// Using a Consumer<T> wrapping the add to cart button is more reactive.
    /// But in this example we will not use.
    /// Do not re-build the widget.
    var cart = Provider.of<CartProvider>(context, listen: false);

    return Container(
      decoration: BoxDecoration(
        borderRadius: radius,
        border: Border.all(
          color: Theme.of(context).primaryColorDark.withAlpha(96),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: radius,
        child: GestureDetector(
          onLongPress: () {
            showDialog(
                context: context,
                builder: (context) {
                  return BackdropFilter(
                    filter: ui.ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                    child: Dialog(
                      backgroundColor: Colors.transparent,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          height: 480,
                          width: double.infinity,
                          child: Stack(
                            // alignment: Alignment.bottomCenter,
                            children: <Widget>[
                              Container(
                                width: double.infinity,
                                child: Image.network(
                                  product.imageURL,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Consumer<FavoritesProvider>(
                                  builder: (_, favorites, child) => IconButton(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    color: Colors.pink,
                                    iconSize: 36,
                                    icon:
                                        Icon(favorites.isFavorite(product.id) ? Icons.favorite : Icons.favorite_border),
                                    onPressed: () => favorites.toggle(product.id),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: BackdropFilter(
                                      filter: ui.ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                                      child: Container(
                                        width: double.infinity,
                                        color: Theme.of(context).primaryColor.withAlpha(48),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                                          child: Container(
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      Text(
                                                        product.title,
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight: FontWeight.w500,
                                                          color: Theme.of(context).primaryColorDark,
                                                        ),
                                                      ),
                                                      Text(
                                                        product.description,
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          color: Theme.of(context).primaryColorDark,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                FlatButton.icon(
                                                  icon: Icon(
                                                    Icons.add_shopping_cart,
                                                    color: Theme.of(context).primaryColorDark,
                                                  ),
                                                  label: Text('Add',
                                                      style: TextStyle(
                                                        color: Theme.of(context).primaryColorDark,
                                                      )),
                                                  onPressed: () {
                                                    cart.add(product);
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                });
          },
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductPage.routeName,
              arguments: ProductPageArgument(
                product: product,
              ),
            );
          },
          child: GridTile(
            child: Image.network(
              product.imageURL,
              fit: BoxFit.cover,
            ),
            header: Align(
              alignment: Alignment.topRight,
              child: Consumer<FavoritesProvider>(
                builder: (_, favorites, child) => IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  color: Colors.pink,
                  icon: Icon(favorites.isFavorite(product.id) ? Icons.favorite : Icons.favorite_border),
                  onPressed: () => favorites.toggle(product.id),
                ),
              ),
            ),
            footer: Padding(
              padding: const EdgeInsets.all(4),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: BackdropFilter(
                  filter: ui.ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                  child: Container(
                    // margin: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withAlpha(64),
                      // borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              '${product.title}',
                              softWrap: false,
                              overflow: TextOverflow.fade,
                              style: TextStyle(
                                color: Theme.of(context).primaryColorDark,
                              ),
                            ),
                          ),
                        ),
                        Material(
                          type: MaterialType.card,
                          color: Theme.of(context).primaryColor.withAlpha(64),
                          child: InkWell(
                            onTap: () {
                              cart.add(product);
                              Scaffold.of(context).hideCurrentSnackBar();
                              Scaffold.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('${product.title} Has been added to cart!'),
                                  duration: Duration(milliseconds: 800),
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Theme.of(context).primaryColorDark,
                                  action: SnackBarAction(
                                    label: 'Undo',
                                    onPressed: () => cart.removeSingle(product),
                                    textColor: Theme.of(context).primaryColorLight,
                                  ),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.add_shopping_cart,
                                color: Theme.of(context).primaryColorDark,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
