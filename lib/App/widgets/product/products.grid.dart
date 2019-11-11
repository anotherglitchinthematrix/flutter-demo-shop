import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:course_008/App/providers/index.dart';
import 'package:course_008/App/widgets/index.dart';

import '../../models/index.dart';

class ProductsGrid extends StatelessWidget {
  void _overView(BuildContext context, {Product product, CartProvider cart}) {
    showDialog(
        context: context,
        builder: (context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
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
                        height: double.infinity,
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
                            icon: Icon(favorites.isFavorite(product.id)
                                ? Icons.favorite
                                : Icons.favorite_border),
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
                              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                              child: Container(
                                width: double.infinity,
                                color: Colors.black.withAlpha(128),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 12),
                                  child: Container(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                product.title,
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                  color: Theme.of(context)
                                                      .primaryColorLight,
                                                ),
                                              ),
                                              Text(
                                                product.description,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Theme.of(context)
                                                      .primaryColorLight,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        FlatButton.icon(
                                          highlightColor: Theme.of(context)
                                              .primaryColorLight
                                              .withAlpha(12),
                                          splashColor: Theme.of(context)
                                              .primaryColorLight
                                              .withAlpha(24),
                                          icon: Icon(
                                            Icons.add_shopping_cart,
                                            color: Theme.of(context)
                                                .primaryColorLight,
                                          ),
                                          label: Text('Add',
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColorLight,
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
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductsProvider>(
      builder: (_, products, child) {
        return GridView.builder(
          padding: const EdgeInsets.all(8),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2 / 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: products.list.length,
          itemBuilder: (context, index) {
            return ProductGridItem(
              products.list[index],
              longPress: _overView,
            );
          },
        );
      },
    );
  }
}
