import 'dart:convert';

import 'package:arosaje_mobile/constants/constant.dart';
import 'package:arosaje_mobile/models/garden.dart';
import 'package:http/http.dart' as http;

class UserService {
  Future<List<Garden>> fetchUserGardens(int userId, String token) async {
    final url = Uri.parse('$API_BASE_URL/users/$userId/gardens');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<Garden> gardens = (jsonDecode(response.body) as List)
          .map((json) => Garden.fromJson(json))
          .toList();

      return gardens;
    } else {
      final responseData = jsonDecode(response.body);
      // Registration failed
      throw Exception(responseData['message']);
    }
  }

  Future<bool> createUserGarden(int userId, token, Garden garden) async {
    final url = Uri.parse('$API_BASE_URL/users/$userId/gardens');

    final body = jsonEncode(garden);

    final response = await http.post(
      url,
      body: body,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 201) {
      //Garden created
      return true;
    } else {
      final responseData = jsonDecode(response.body);
      // Registration failed
      throw Exception(responseData['message']);
    }
  }
}
