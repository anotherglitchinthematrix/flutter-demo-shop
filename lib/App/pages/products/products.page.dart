import 'package:flutter/material.dart';
import 'package:course_008/App/widgets/index.dart';

class ProductsPage extends StatefulWidget {
  static const routeName = 'products';

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  bool _showFavorites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop App'),
        actions: <Widget>[
          IconButton(
            icon: Icon(_showFavorites ? Icons.radio_button_checked : Icons.radio_button_unchecked),
            onPressed: () {
              setState(() {
                _showFavorites = !_showFavorites;
              });
            },
          ),
        ],
      ),
      body: ProductsGrid(
        showFavorites: _showFavorites,
      ),
    );
  }
}
