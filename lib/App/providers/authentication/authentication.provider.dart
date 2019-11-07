import 'dart:convert';
import 'dart:async';

import 'package:course_008/App/models/index.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class AuthenticationProvider extends ChangeNotifier {
  final apiKey = 'AIzaSyCWK_PAhVO3Ec5Vr0-G_7ge68X81TPCcms';
  String _token;
  DateTime _expireDate;
  String _userId;

  String get token {
    if (_token != null && _expireDate != null && _expireDate.isAfter(DateTime.now())) {
      return _token;
    }
    return null;
  }

  String get userId => _userId;
  bool get isAuthenticated => token != null;

  Future<void> _authenticate(String url, {String mail, String password}) async {
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'email': mail,
          'password': password,
          'returnSecureToken': true,
        }),
      );

      final decoded = json.decode(response.body) as Map<String, dynamic>;

      if (decoded['error'] != null) {
        throw HttpException(decoded['error']['message']);
      }

      _token = decoded['idToken'];
      _userId = decoded['localId'];
      _expireDate = DateTime.now().add(Duration(seconds: int.parse(decoded['expiresIn'])));

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> signUp(String mail, String password) async {
    final url = 'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=[KEY]'.replaceAll('[KEY]', apiKey);

    return _authenticate(
      url,
      mail: mail,
      password: password,
    );
  }

  Future<void> signIn(String mail, String password) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=[KEY]'.replaceAll('[KEY]', apiKey);
    return _authenticate(
      url,
      mail: mail,
      password: password,
    );
  }

  void logOut() {
    _token = null;
    _userId = null;
    _expireDate = null;
    notifyListeners();
  }

  void _autoLogOut() {
    final logOutTime = _expireDate.difference(DateTime.now());
    Timer(logOutTime, logOut);
  }
}
