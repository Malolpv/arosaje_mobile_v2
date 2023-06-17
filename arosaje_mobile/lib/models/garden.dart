import 'dart:ffi';

class Garden {
  final int id;
  final String name;
  final Double latitude;
  final Double longitude;
  final String picture;
  final int user_id;

  Garden(
      {required this.id,
      required this.name,
      required this.latitude,
      required this.longitude,
      required this.picture,
      required this.user_id});

  factory Garden.fromJson(Map<String, dynamic> json) {
    return Garden(
        id: json['id'],
        name: json['name'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        picture: json['picture'],
        user_id: json['user']);
  }
}
