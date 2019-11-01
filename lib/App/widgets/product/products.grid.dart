import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:course_008/App/providers/index.dart';
import 'package:course_008/App/widgets/index.dart';

class ProductsGrid extends StatelessWidget {
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
            return ProductGridItem(products.list[index]);
          },
        );
      },
    );
  }
}
