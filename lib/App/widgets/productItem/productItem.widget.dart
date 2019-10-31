import 'package:course_008/App/pages/index.dart';
import 'package:flutter/material.dart';
import 'package:course_008/App/models/index.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  ProductItem(this.product);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(8), // might be 9 to match with ClipRRect
        border: Border.all(
          color: Theme.of(context).primaryColorDark.withAlpha(96),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) {
                return ProductPage(product);
              }),
            );
          },
          child: GridTile(
            child: Image.network(
              product.imageURL,
              fit: BoxFit.cover,
            ),
            header: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                color: Colors.pink,
                icon: Icon(Icons.favorite_border),
                onPressed: () {},
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
                backgroundColor:
                    Theme.of(context).primaryColorDark.withAlpha(48),
                title: Text(
                  product.title,
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                    color: Theme.of(context).primaryColorDark,
                    fontFamily: 'Inter',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                trailing: IconButton(
                  color: Theme.of(context).primaryColor,
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () {},
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
