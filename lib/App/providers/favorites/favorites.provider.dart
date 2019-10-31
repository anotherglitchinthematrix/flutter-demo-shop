import 'package:flutter/widgets.dart';

class FavoritesProvider with ChangeNotifier {
  final List<String> _favorites = [];

  List<String> get favorites => _favorites;

  void toggle(String id) {
    if (_favorites.contains(id)) {
      this._remove(id);
    } else {
      this._add(id);
    }
    notifyListeners();
  }

  void _add(String id) {
    _favorites.add(id);
  }

  void _remove(String id) {
    _favorites.remove(id);
  }
}
