import 'package:flutter/material.dart';
import 'package:course_008/App/models/index.dart';
import 'package:course_008/App/widgets/index.dart';

class ProductsGrid extends StatelessWidget {
  ProductsGrid({
    this.products,
  });

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductItem(products[index]);
      },
    );
  }
}
