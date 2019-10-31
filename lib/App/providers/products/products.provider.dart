import 'package:flutter/material.dart';
import 'package:course_008/App/models/index.dart';
import 'package:course_008/App/dummy/index.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _products = [...dummyProducts];

  List<Product> get products => _products;

  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }
}
