import 'package:flutter/material.dart';
import 'package:course_008/App/models/index.dart';
import 'package:course_008/App/dummy/index.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _products = [...dummyProducts];

  List<Product> get list => _products;

  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
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
