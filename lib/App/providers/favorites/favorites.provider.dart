import 'dart:convert';

import 'package:course_008/App/models/exception/http.exception.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';

class FavoritesProvider with ChangeNotifier {
  FavoritesProvider(this.authToken, this.userID);
  String authToken;
  String userID;

  final Map<String, String> _favorites = {};

  Map<String, String> get favorites => _favorites;

  bool isFavorite(String id) {
    return _favorites.containsValue(id);
  }

  void toggle(String id) {
    if (this.isFavorite(id)) {
      this._remove(id);
    } else {
      this._add(id);
    }

    notifyListeners();
  }

  Future<void> fetch() async {
    try {
      final url = 'https://flutter-shop-a3a3e.firebaseio.com/favorites/$userID.json?auth=$authToken';
      var response = await http.get(url);

      var favorites = json.decode(response.body) as Map<String, dynamic>;

      if (favorites != null) {
        favorites.forEach((key, value) {
          _favorites[key] = value;
        });
      }
      // notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  void _add(String id) {
    final url = 'https://flutter-shop-a3a3e.firebaseio.com/favorites/$userID.json?auth=$authToken';

    // optimistic update.
    var entry = _favorites.entries.firstWhere((f) => f.value == id, orElse: () {
      MapEntry<String, String> _entry = MapEntry("", id);
      _favorites.addEntries([_entry]);
      return _entry;
    });

    http.post(url, body: json.encode(id)).then((response) {
      if (response.statusCode >= 400) {
        throw HttpException('Couldn\'t add to the favorites');
      }

      // for optimistic update;
      // - remove the keyless placeholder value and re-add with key.
      String key = json.decode(response.body)['name'];
      _favorites.remove(entry.key);
      _favorites.addAll({key: id});
    }).catchError((_) {
      // on error, roll back.
      _favorites.remove(id);
      notifyListeners();
    });
  }

  void _remove(String id) {
    var entry = _favorites.entries.firstWhere((e) => e.value == id);
    _favorites.remove(entry.key);

    print(entry);
    final url = "https://flutter-shop-a3a3e.firebaseio.com/favorites/$userID/${entry.key}.json?auth=$authToken";

    http.delete(url).then((response) {
      if (response.statusCode >= 400) {
        throw HttpException('Couldn\'t remove from favorites');
      }
    }).catchError((_) {
      // on Error re-add.
      _favorites[entry.key] = entry.value;
      notifyListeners();
    });
  }
}
