// import 'package:course_008/App/dummy/cart/cart.dummy.dart';
import 'dart:convert';

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

  String get toJson {
    return json.encode({
      'product': this.product.toJsonWithId,
      'quantity': this.quantity,
    });
  }
}

class CartProvider with ChangeNotifier {
  List<CartItem> _list = [];

  List<CartItem> get list => _list;

  int get count => this._list.length;

  bool get isEmpty => this.count == 0;

  /// Get the total amount of the cart items.
  double get totalAmount {
    return _list.fold(0, (total, item) => total + (item.quantity * item.product.price));
  }

  void add(Product product) {
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

  void remove(CartItem item) {
    _list.remove(item);
    notifyListeners();
  }

  void removeSingle(Product item) {
    try {
      var _item = _list.firstWhere((i) => i.product == item);

      if (_item.quantity > 1) {
        _item.quantity = _item.quantity - 1;
      } else {
        _list.removeWhere((i) => i.product == item);
      }

      notifyListeners();
    } on StateError {
      // StateError is thrown when no item is present.
      return;
    }
  }

  void clear() {
    this._list = [];
    notifyListeners();
  }
}
