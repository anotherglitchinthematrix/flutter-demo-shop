import 'package:course_008/App/models/index.dart';
import 'package:flutter/material.dart';

class CartItem {
  CartItem({
    @required this.id,
    @required this.product,
    this.quantity = 0,
  });

  final String id;
  final Product product;
  int quantity;
}

class CartProvider with ChangeNotifier {
  List<CartItem> _list = [];

  List<CartItem> get list => _list;

  String get count => this._list.length.toString();

  void addToCart(Product product) {
    /// try to find the item in the cart,
    /// if it's present return the item.
    /// if it's not present create and return the item.
    CartItem item = _list.firstWhere(
      (item) => item.product == product,
      orElse: () {
        CartItem _item = CartItem(
          id: DateTime.now().toString(),
          product: product,
        );

        _list.add(_item);

        return _item;
      },
    );

    item.quantity++;
    notifyListeners();
  }
}
