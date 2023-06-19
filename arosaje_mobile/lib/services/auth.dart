import 'dart:convert';
import 'package:arosaje_mobile/constants/constant.dart';
import 'package:arosaje_mobile/store/token_manager.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AuthService {
  static const String apiUrl = API_BASE_URL; // Replace with your API URL

  Future<String> registerUser(
      String pseudo, String email, String password) async {
    final url = Uri.parse('$apiUrl/register');

    final user = {
      "pseudo": pseudo,
      "email": email,
      "password": password,
      "isBotaniste": false
    };

    String body = jsonEncode(user);

    final response = await http.post(
      url,
      body: body,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      // Registration successful
      final token = json.decode(response.body)['token'];

      return token;
    } else {
      final responseData = jsonDecode(response.body);
      // Registration failed
      throw Exception(responseData['message']);
    }
  }

  Future<String> login(String email, String password) async {
    final url = Uri.parse('$apiUrl/login');

    final user = {
      "email": email,
      "password": password,
    };

    String body = jsonEncode(user);

    final response = await http.post(
      url,
      body: body,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      // Registration successful
      final token = json.decode(response.body)['token'];

      return token;
    } else {
      final responseData = jsonDecode(response.body);
      // Registration failed
      throw Exception(responseData['message']);
    }
  }

  // Add other API methods for login, logout, etc.
}
