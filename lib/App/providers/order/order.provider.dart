import 'package:flutter/foundation.dart';
import 'package:course_008/App/providers/index.dart';

class OrderItem {
  OrderItem({
    this.id,
    this.cart,
    this.total,
    this.date,
  });
  String id;
  List<CartItem> cart;
  double total;
  DateTime date;
}

class OrderProvider with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get list => _orders;

  void order(List<CartItem> cart, double total) {
    _orders.add(OrderItem(
      id: DateTime.now().toString(),
      cart: cart,
      total: total,
      date: DateTime.now(),
    ));

    notifyListeners();
  }
}
