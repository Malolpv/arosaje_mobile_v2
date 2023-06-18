import 'dart:convert';

import 'package:arosaje_mobile/models/garden.dart';

class User {
  final int id;
  final String pseudo;
  final String email;
  final String password;
  final bool isBotaniste;
  List<Garden> gardens;

  User(
      {required this.id,
      required this.pseudo,
      required this.email,
      required this.password,
      required this.isBotaniste,
      this.gardens = const []});

  factory User.fromJson(Map<String, dynamic> json) {
    // List<Garden> gardens = (json.decode['gardens'] as List)
    //     .map((gardenJson) => Garden.fromJson(gardenJson))
    //     .toList();

    return User(
      id: json['id'],
      pseudo: json['pseudo'],
      email: json['email'],
      password: json['password'],
      isBotaniste: json['is_botaniste'],
      // gardens: gardens,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['pseudo'] = pseudo;
    data['email'] = email;
    data['password'] = password;
    data['is_botaniste'] = isBotaniste;

    return data;
  }
}
