import 'dart:convert';
import 'package:flutter/foundation.dart';

class Product {
  String id;
  String title;
  String description;
  double price;
  String imageURL;
  String creator;
  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageURL,
    @required this.creator,
  });

  String get toJson {
    return json.encode({
      'title': this.title,
      'description': this.description,
      'price': this.price,
      'imageURL': this.imageURL,
      'creator': this.creator,
    });
  }

  String get toJsonWithId {
    return json.encode({
      'id': this.id,
      'title': this.title,
      'description': this.description,
      'price': this.price,
      'imageURL': this.imageURL,
    });
  }
}
