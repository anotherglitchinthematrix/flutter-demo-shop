import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:course_008/App/models/index.dart';
import 'package:course_008/App/dummy/index.dart';

class ProductsProvider with ChangeNotifier {
  String url = 'https://flutter-shop-a3a3e.firebaseio.com/products.json';

  List<Product> _products = [...dummyProducts];

  List<Product> get list => _products;

  Future<void> addProduct(Product product) async {
    //in async doesn't need to return.
    try {
      final response = await http.post(url, body: product.toJson);
      var id = json.decode(response.body)['name'];
      product.id = id;
      _products.add(product);
      notifyListeners();
    } catch (error) {
      print(error.toString());
      throw error;
    }
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
