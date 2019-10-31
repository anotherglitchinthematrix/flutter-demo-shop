import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:course_008/App/providers/index.dart';
import 'package:course_008/App/widgets/index.dart';

class ProductsGrid extends StatelessWidget {
  ProductsGrid({this.showFavorites = false});
  final bool showFavorites;

  @override
  Widget build(BuildContext context) {
    final favorites = Provider.of<FavoritesProvider>(context).favorites;

    return Consumer<ProductsProvider>(
      builder: (_, products, child) {
        var list =
            !showFavorites ? products.list : products.list.where((product) => favorites.contains(product.id)).toList();

        return GridView.builder(
          padding: const EdgeInsets.all(8),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2 / 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: list.length,
          itemBuilder: (context, index) {
            return ProductItem(list[index]);
          },
        );
      },
    );
  }
}
