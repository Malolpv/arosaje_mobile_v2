import 'dart:io';

import 'package:arosaje_mobile/navigation/navigation.dart';
import 'package:arosaje_mobile/services/auth.dart';
import 'package:arosaje_mobile/store/token_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginController extends ChangeNotifier {
  //Attributes
  String? _email;
  String? _password;

  //accessors
  String? get getEmail => _email;
  String? get getPassword => _password;

  String? isEmailValid(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email ne peut pas être vide';
    } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
        .hasMatch(value)) {
      return 'Email invalide';
    }
    return null;
  }

  String? isPasswordValid(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez saisir un mot de passe';
    }
    return null;
  }

  Future<String> login(
      BuildContext context, String email, String password) async {
    String message = "Bienvenue !";
    // Simulate an asynchronous registration process
    AuthService authService = AuthService();

    try {
      String token = await authService.login(email, password);
      Provider.of<TokenController>(context, listen: false).setToken(token);
    } on SocketException {
      message = "Impossible de joindre le serveur de connection";
    } on Exception catch (error) {
      message = error.toString().split(': ')[1];
    }

    Provider.of<NavigationController>(context, listen: false).changeScreen('/');
    return message;
  }
}
