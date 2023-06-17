import 'package:arosaje_mobile/models/garden.dart';

class User {
  final int id;
  final String pseudo;
  final String email;
  final String password;
  List<Garden> gardens;

  User(
      {required this.id,
      required this.pseudo,
      required this.email,
      required this.password,
      this.gardens = const []});

  factory User.fromJson(Map<String, dynamic> json) {
    List<Garden> gardens = (json['gardens'] as List)
        .map((gardenJson) => Garden.fromJson(gardenJson))
        .toList();

    return User(
      id: json['id'],
      pseudo: json['pseudo'],
      email: json['email'],
      password: json['password'],
      gardens: gardens,
    );
  }
}
