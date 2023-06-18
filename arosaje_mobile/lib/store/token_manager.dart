import 'package:arosaje_mobile/utils/utils.dart';
import 'package:flutter/material.dart';

class TokenController extends ChangeNotifier {
  String? _token;

  void setToken(String newToken) {
    _token = newToken;
    notifyListeners();
  }

  void _expireToken() {
    _token = null;
    notifyListeners();
  }

  String? getToken() {
    String? token = _token;

    //token is expire we set it back to null
    if (token != null && Utils.isTokenExpire(token)) {
      _expireToken();
    }

    return token;
  }
}
