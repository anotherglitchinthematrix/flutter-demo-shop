import 'dart:convert';

import 'package:course_008/App/models/exception/http.exception.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';

class FavoritesProvider with ChangeNotifier {
  final List<String> _favorites = [];

  List<String> get favorites => _favorites;

  bool isFavorite(String id) {
    return _favorites.contains(id);
  }

  void toggle(String id) {
    if (this.isFavorite(id)) {
      this._remove(id);
    } else {
      this._add(id);
    }

    notifyListeners();
  }

  void _add(String id) {
    const url = 'https://flutter-shop-a3a3e.firebaseio.com/favorites.json';

    // optimistic update.
    _favorites.add(id);

    http.post(url, body: json.encode(id)).then((response) {
      if (response.statusCode >= 400) {
        throw HttpException('Couldn\'t add to the favorites');
      }
    }).catchError((_) {
      // if error, roll back.
      _favorites.remove(id);
      notifyListeners();
    });
  }

  void _remove(String id) {
    _favorites.remove(id);
  }
}
