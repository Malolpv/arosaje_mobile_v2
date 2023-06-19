import 'dart:convert';
import 'dart:io' as io;

import 'package:arosaje_mobile/models/garden.dart';
import 'package:arosaje_mobile/services/user.dart';
import 'package:arosaje_mobile/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddGardenController extends ChangeNotifier {
  //attributes
  XFile? _image;
  final String _token;
  String? _errorMessage;
  String? _requestErrorMessage;

  //accessors
  XFile? get image => _image;
  String? get errorMessage => _errorMessage;
  String? get requestErrorMessage => _requestErrorMessage;

  //constructor
  AddGardenController(this._token);

  //methods
  String? isNameValid(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez saisir un nom d\'au moins 5 caractères';
    }
    return null;
  }

  void selectImage(XFile? image) {
    if (image != null) {
      _image = image;
      _errorMessage = null;
    } else {
      _errorMessage = "Erreur : Impossible de sélectionner cette image";
    }
    notifyListeners();
  }

  Future<bool> addGarden(String name) async {
    XFile? image = _image;

    bool success = false;

    //if image isnt null convert to base 64 for storage
    if (image != null) {
      final UserService userService = UserService();

      //retrieve logged user
      final loggedUserId = Utils.getPayloadFromToken(_token)['id'];

      final bytes = io.File(image.path).readAsBytesSync();
      String picture = base64Encode(bytes);

      Garden garden = Garden(
          id: 0,
          name: name,
          latitude: 0,
          longitude: 0,
          picture: picture,
          userId: loggedUserId);

      try {
        success =
            await userService.createUserGarden(loggedUserId, _token, garden);
      } on io.SocketException {
        _requestErrorMessage = 'Erreur de connexion';
      } on Exception catch (error) {
        _requestErrorMessage = error.toString().split(": ")[1];
      }
    }

    notifyListeners();
    return success;
  }
}
