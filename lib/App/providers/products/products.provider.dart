import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:course_008/App/models/index.dart';
import 'package:course_008/App/dummy/index.dart';

class ProductsProvider with ChangeNotifier {
  String url = 'https://flutter-shop-a3a3e.firebaseio.com/products.json';

  List<Product> _products = [...dummyProducts];

  List<Product> get list => _products;

  Future<void> addProduct(Product product) {
    return http.post(url, body: product.toJson).then((response) {
      var id = json.decode(response.body)['name'];
      product.id = id;
      _products.add(product);
      // print(product.id);
      notifyListeners();
    });
  }

  void deleteProduct(Product product) {
    _products.remove(product);
    notifyListeners();
  }

  void patchProduct(Product product) {
    var index = _products.indexWhere((p) => p.id == product.id);
    if (index != -1) {
      _products[index] = product;
      notifyListeners();
    }
  }
}
