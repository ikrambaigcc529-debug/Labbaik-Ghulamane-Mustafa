import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Base URL setup: static const String baseUrl = 'http://192.168.11.23:5000';
  // Android Emulator ke liye: 'http://10.0.2.2:5000/api'
  // Windows desktop app ke liye: 'http://localhost:5000/api'
  static const String baseUrl = 'http://192.168.11.23:5000/api';

  static Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/auth/login');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {'success': true, 'data': data};
      } else {
        return {'success': false, 'message': data['message'] ?? 'Login fail ho gaya'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Server se connection nahi ho saka: $e'};
    }
  }
}