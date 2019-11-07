import 'dart:convert';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:course_008/App/models/index.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class AuthenticationProvider extends ChangeNotifier {
  final apiKey = 'AIzaSyCWK_PAhVO3Ec5Vr0-G_7ge68X81TPCcms';
  String _token;
  DateTime _expireDate;
  String _userId;
  Timer _authTimer;

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
      _autoLogOut();

      notifyListeners();

      // after succesfull login save the credentials to the shared pereferences
      final storage = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'userId': _userId,
        'expireDate': _expireDate.toIso8601String(),
      });

      // don't await.
      storage.setString('userData', userData);
    } catch (error) {
      throw error;
    }
  }

  Future<bool> tryAutoLogin() async {
    final storage = await SharedPreferences.getInstance();

    if (!storage.containsKey('userData')) {
      return false;
    }

    final extractedUserData = json.decode(storage.getString('userData'));

    final expireDate = DateTime.parse(extractedUserData['expireDate']);

    // token is expired.
    if (expireDate.isBefore(DateTime.now())) {
      return false;
    }

    _token = extractedUserData['token'];
    _userId = extractedUserData['userId'];
    _expireDate = expireDate;

    // wait a while to show the splash screen.
    await Future.delayed(Duration(seconds: 1));

    notifyListeners();

    _autoLogOut();

    return true;
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

  Future<void> logOut() async {
    _token = null;
    _userId = null;
    _expireDate = null;
    if (_authTimer != null) {
      _authTimer.cancel();
    }

    notifyListeners();

    // authstates could be stored as enums and when logging out we should show a goodbye screen
    // await Future.delayed(Duration(seconds: 8));

    final storage = await SharedPreferences.getInstance();
    // delete only some specific data:
    // storage.remove('userData');

    // purge all prefs.
    storage.clear();
  }

  void _autoLogOut() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }

    final logOutTime = _expireDate.difference(DateTime.now());
    // final logOutTime = Duration(seconds: 10);
    _authTimer = Timer(logOutTime, logOut);
  }
}
