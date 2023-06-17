import 'package:arosaje_mobile/services/auth.dart';
import 'package:flutter/material.dart';

class RegisterController extends ChangeNotifier {
  //Attributes
  String? _pseudo;
  String? _email;
  String? _password;

  String? _pseudoErrorMessage;
  String? _emailErrorMessage;
  String? _passwordErrorMessage;

  String? _message;

  //accessors
  String? get getPseudo => _pseudo;
  String? get getEmail => _email;
  String? get getPassword => _password;

  String? get getPseudoErrorMessage => _pseudoErrorMessage;
  String? get getEmailErrorMessage => _emailErrorMessage;
  String? get getPasswordErrorMessage => _passwordErrorMessage;

  String? get getMessage => _message;

  String? isEmailValid(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email ne peut pas être vide';
    } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
        .hasMatch(value)) {
      return 'Email invalide';
    }
    return null;
  }

  String? isPseudoValid(String? value) {
    if (value == null || value.length < 4) {
      return '4 caractères minimum';
    }
    return null;
  }

  String? isPasswordValid(String? value) {
    if (value == null || value.length < 8) {
      return '8 caractères minimum';
    }
    return null;
  }

  Future<String> registerUser(
      String pseudo, String email, String password) async {
    String message = "Votre compte à été créé";
    // Simulate an asynchronous registration process
    AuthService authService = AuthService();

    try {
      await authService.registerUser(pseudo, email, password);
    } on Exception catch (error) {
      message = error.toString().split(': ')[1];
    }

    return message;
  }
}
