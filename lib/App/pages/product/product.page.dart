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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 8),
                width: double.infinity,
                height: 256,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 1),
                      blurRadius: 8,
                      spreadRadius: -6,
                    )
                  ],
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(8),
                  ),
                  color: Theme.of(context).primaryColorLight,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(8),
                  ),
                  child: Image.network(
                    product.imageURL,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              new _ActionContainer(product: product),
              Container(
                height: 500,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Theme.of(context).primaryColorLight,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionContainer extends StatelessWidget {
  const _ActionContainer({
    @required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    // var favorites = Provider.of<FavoritesProvider>(context);

    return Container(
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Material(
              borderRadius: BorderRadius.circular(4),
              color: Theme.of(context).primaryColor.withAlpha(48),
              type: MaterialType.button,
              child: InkWell(
                onTap: () {
                  Provider.of<CartProvider>(context).add(product);
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${product.title} Has been added to cart!'),
                      duration: Duration(seconds: 800),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Theme.of(context).primaryColorDark,
                    ),
                  );
                },
                splashColor: Theme.of(context).primaryColor.withAlpha(72),
                highlightColor: Theme.of(context).primaryColor.withAlpha(64),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.shopping_cart,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        'Add to cart',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500, color: Theme.of(context).primaryColorDark),
                      ),
                      Spacer(),
                      Text(
                        '\$ ${product.price.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).primaryColorDark,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Material(
            type: MaterialType.button,
            borderRadius: BorderRadius.circular(4),
            color: Colors.pink.withAlpha(36),
            child: Consumer<FavoritesProvider>(
              builder: (context, favorites, _) {
                return InkWell(
                  splashColor: Colors.pink.withAlpha(48),
                  highlightColor: Colors.pink.withAlpha(64),
                  onTap: () => favorites.toggle(product.id),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Icon(
                      favorites.isFavorite(product.id) ? Icons.favorite : Icons.favorite_border,
                      color: Colors.pink,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
