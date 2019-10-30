import 'package:flutter/material.dart';
import 'package:course_008/App/models/index.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  ProductItem(this.product);

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Image.network(
        product.imageURL,
        fit: BoxFit.cover,
      ),
    );
  }
}
