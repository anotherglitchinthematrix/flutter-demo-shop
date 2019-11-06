import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:course_008/App/models/index.dart';
// import 'package:course_008/App/dummy/index.dart';

class ProductsProvider with ChangeNotifier {
  String insertUrl = 'https://flutter-shop-a3a3e.firebaseio.com/products.json';

  List<Product> _products = [];

  List<Product> get list => _products;

  Future<void> addProduct(Product product) async {
    //in async doesn't need to return.
    try {
      final response = await http.post(insertUrl, body: product.toJson);
      var id = json.decode(response.body)['name'];
      product.id = id;
      _products.add(product);
      notifyListeners();
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  Future<void> deleteProduct(Product product) async {
    String url = 'https://flutter-shop-a3a3e.firebaseio.com/products/${product.id}.json';

    _products.remove(product);
    notifyListeners();
    // optimistic update pattern, do in demand but if it fails undo the action.
    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      // re-add the removed product
      _products.add(product);
      throw HttpException('Could not delete the product');
    }
  }

  Future<void> patchProduct(Product product) async {
    String url = 'https://flutter-shop-a3a3e.firebaseio.com/products/${product.id}.json';

    try {
      var index = _products.indexWhere((p) => p.id == product.id);
      if (index != -1) {
        await http.patch(
          url,
          body: product.toJson,
        );
        _products[index] = product;
        notifyListeners();
      }
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  Future<void> fetch() async {
    try {
      final response = await http.get(insertUrl);
      final extracted = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProduct = [];
      extracted.forEach((key, value) {
        loadedProduct.add(Product(
          id: key,
          title: value['title'],
          description: value['description'],
          price: value['price'],
          imageURL: value['imageURL'],
        ));
      });

      this._products = loadedProduct;
      // prevenet empty page on hot-reload.
      // using this with futurebuilder causes a loop call.
      // notifyListeners();
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }
}
