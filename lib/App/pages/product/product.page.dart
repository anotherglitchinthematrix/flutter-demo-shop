import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:course_008/App/models/index.dart';
import 'package:course_008/App/providers/index.dart';

/// An interface to extract the data easily passed by the namedRoute.
class ProductPageArgument {
  final Product product;

  ProductPageArgument({
    this.product,
  });
}

class ProductPage extends StatelessWidget {
  static const routeName = 'product';

  @override
  Widget build(BuildContext context) {
    final ProductPageArgument argument = ModalRoute.of(context).settings.arguments;
    final Product product = argument.product;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        actions: <Widget>[
          Consumer<FavoritesProvider>(
            builder: (_, favorites, child) => IconButton(
              icon: Icon(favorites.isFavorite(product.id) ? Icons.favorite : Icons.favorite_border),
              onPressed: () => favorites.toggle(product.id),
            ),
          ),
        ],
      ),
    );
  }
}
