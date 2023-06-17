import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String apiUrl =
      'http://127.0.0.1:5000/api/v1'; // Replace with your API URL

  Future<bool> registerUser(
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
      final responseData = json.decode(response.body);
      //TODO handle token

      return true;
    } else {
      final responseData = jsonDecode(response.body);
      // Registration failed
      throw Exception(responseData['message']);
    }
  }

  Future<bool> login(String email, String password) async {
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
      final responseData = json.decode(response.body);
      //TODO Handle token

      return true;
    } else {
      final responseData = jsonDecode(response.body);
      // Registration failed
      throw Exception(responseData['message']);
    }
  }

  // Add other API methods for login, logout, etc.
}
