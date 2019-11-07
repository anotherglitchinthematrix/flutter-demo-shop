import 'dart:convert';

import 'package:course_008/App/models/index.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class AuthenticationProvider extends ChangeNotifier {
  final apiKey = 'AIzaSyCWK_PAhVO3Ec5Vr0-G_7ge68X81TPCcms';
  // String _token;
  // DateTime _expireDate;
  // String _userId;

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
}
