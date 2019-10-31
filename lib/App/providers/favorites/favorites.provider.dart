import 'package:flutter/widgets.dart';

class FavoritesProvider with ChangeNotifier {
  final List<String> _favorites = ['p1'];

  List<String> get favorites => _favorites;

  bool isFavorite(String id) {
    return _favorites.contains(id);
  }

  void toggleFavorite(String id) {
    if (this.isFavorite(id)) {
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
