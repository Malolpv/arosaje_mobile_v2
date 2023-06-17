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

  Future<bool> registerUser(
      String pseudo, String email, String password) async {
    // Simulate an asynchronous registration process
    await Future.delayed(const Duration(seconds: 2));

    // Perform your registration logic here
    // You can send the registration data to an API, validate it, etc.

    // Simulate registration success
    bool registrationSuccess = true;
    _message = 'Erreur lors de la création du compte';

    notifyListeners();
    return registrationSuccess;
  }
}
