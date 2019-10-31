import 'package:flutter/material.dart';
import 'package:course_008/App/models/index.dart';

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

    return Scaffold(
      appBar: AppBar(
        title: Text(argument.product.title),
      ),
    );
  }
}
