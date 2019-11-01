import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:course_008/App/models/index.dart';
import 'package:course_008/App/providers/index.dart';
import 'package:course_008/App/pages/index.dart';

class ProductItem extends StatelessWidget {
  ProductItem(this.product);

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
                  color: Colors.pink,
                  icon: Icon(favorites.isFavorite(product.id) ? Icons.favorite : Icons.favorite_border),
                  onPressed: () => favorites.toggle(product.id),
                ),
              ),
            ),
            footer: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Theme.of(context).primaryColor.withAlpha(96),
                    width: 1,
                  ),
                ),
              ),
              child: GridTileBar(
                backgroundColor: Theme.of(context).primaryColorDark.withAlpha(48),
                title: Text(
                  product.title,
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                    color: Theme.of(context).primaryColorDark,
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                trailing: IconButton(
                  color: Theme.of(context).primaryColor,
                  icon: Icon(Icons.add_shopping_cart),
                  onPressed: () {
                    cart.addToCart(product.id);
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${product.title} Has been added to cart!'),
                        duration: Duration(milliseconds: 800),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Theme.of(context).primaryColorDark,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
