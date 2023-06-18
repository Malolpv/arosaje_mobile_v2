import 'dart:io';

import 'package:arosaje_mobile/models/garden.dart';
import 'package:arosaje_mobile/models/user.dart';
import 'package:arosaje_mobile/services/user.dart';
import 'package:arosaje_mobile/utils/utils.dart';
import 'package:flutter/widgets.dart';

class ListGardensController extends ChangeNotifier {
  //attributes
  List<Garden> _gardens = [];
  String? _errorMessage;
  final String _token;

  //accessors
  List<Garden> get gardens => _gardens;
  String? get errorMessage => _errorMessage;

  //constructor
  ListGardensController(this._token);

  //methods

  Future<List<Garden>> fetchGardens() async {
    UserService userService = UserService();

    //retrieve logged user
    final logedUserId = Utils.getPayloadFromToken(_token)['id'];

    try {
      _gardens = await userService.fetchUserGardens(logedUserId, _token);
    } on SocketException {
      _errorMessage = 'Erreur de connexion';
    } on Exception catch (error) {
      _errorMessage = error.toString().split(": ")[1];
    }
    notifyListeners();
    return _gardens;
  }
}
