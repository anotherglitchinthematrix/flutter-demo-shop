import 'package:flutter/material.dart';

class CartItem {
  CartItem({
    @required this.id,
    @required this.productId,
    this.quantity = 0,
  });

  final String id;
  final String productId;
  int quantity;
}

class CartProvider with ChangeNotifier {
  List<CartItem> _list = [];

  List<CartItem> get list => _list;

  void addToCart(String productId) {
    /// try to find the item in the cart,
    /// if it's present return the item.
    /// if it's not present create and return the item.
    CartItem item = _list.firstWhere(
      (item) => item.productId == productId,
      orElse: () {
        CartItem _item = CartItem(
          id: DateTime.now().toString(),
          productId: productId,
        );

        _list.add(_item);

        return _item;
      },
    );

    item.quantity++;
    print(this);
  }

  @override
  String toString() {
    _list.forEach((i) => print('${i.id}, ${i.productId}, ${i.quantity}'));
    return '';
  }
}
