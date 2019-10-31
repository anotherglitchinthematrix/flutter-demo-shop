import 'package:flutter/material.dart';
import 'package:course_008/App/widgets/index.dart';

class ProductsPage extends StatelessWidget {
  static const routeName = 'products';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop App'),
      ),
      body: ProductsGrid(),
    );
  }
}
