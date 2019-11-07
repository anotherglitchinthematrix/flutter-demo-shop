// import 'package:course_008/App/dummy/index.dart';
import 'dart:convert';

import 'package:course_008/App/models/index.dart';
import 'package:http/http.dart' as http;
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

  String get toJson {
    return json.encode({
      'date': DateTime.now().toIso8601String(),
      'total': this.total,
      'cart': this.cart.map((i) => i.toJson).toList(),
    });
  }
}

class OrderProvider with ChangeNotifier {
  OrderProvider(this.authToken);

  String authToken;

  List<OrderItem> _orders = [];

  List<OrderItem> get list => _orders;

  Future<void> fetch() async {
    final url = 'https://flutter-shop-a3a3e.firebaseio.com/orders.json?auth=$authToken';
    final response = await http.get(url);
    // print(json.decode(response.body));
    final List<OrderItem> loadedList = [];

    final extractedData = json.decode(response.body) as Map<String, dynamic>;

    if (extractedData != null) {
      extractedData.forEach((orderId, orderData) {
        loadedList.add(OrderItem(
          id: orderId,
          date: DateTime.parse(orderData['date']),
          total: orderData['total'],
          cart: (orderData['cart'] as List<dynamic>).map((m) {
            var data = json.decode(m);
            var product = json.decode(data['product']);
            var quantity = data['quantity'];

            return CartItem(
              id: '',
              product: Product(
                id: product['id'],
                title: product['title'],
                description: product['description'],
                price: product['price'],
                imageURL: product['imageURL'],
                creator: product['creator'],
              ),
              quantity: quantity,
            );

            // print(item['id']);
          }).toList(),
        ));
      });

      // using with futurebuilder and notifylistener causing infinite loop, be aware.
      // notifyListeners();
    }
    _orders = loadedList.toList();
    // print('döne');
  }

  Future<void> place(List<CartItem> cart, double total) async {
    try {
      final url = 'https://flutter-shop-a3a3e.firebaseio.com/orders.json?auth=$authToken';

      var order = OrderItem(
        cart: cart,
        total: total,
        date: DateTime.now(),
      );

      var response = await http.post(url, body: order.toJson);
      var id = json.decode(response.body)['name'];

      order.id = id;

      _orders.add(order);

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
