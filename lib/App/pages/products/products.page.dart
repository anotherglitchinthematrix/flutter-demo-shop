import 'package:flutter/material.dart';

import 'package:course_008/App/widgets/index.dart';
import 'package:course_008/App/dummy/index.dart';

class ProductsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop App'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: dummyProducts.length,
        itemBuilder: (context, index) {
          return ProductItem(dummyProducts[index]);
        },
      ),
    );
  }
}
