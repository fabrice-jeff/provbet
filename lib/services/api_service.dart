import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/user.dart';

class ApiService {
  final String baseUrl = 'https://provbet.com/api'; // Corrected base URL
  late SharedPreferences prefs;
  String? token;

  ApiService() {
    _init();
  }

  Future<void> _init() async {
    prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    print('Token: $token');
  }

  Future<User> fetchCurrentUser() async {
    // Ensure _init() is completed before using `token`
    await _init();

    if (token == null) {
      throw Exception('Token is null. Please login again.');
    }

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/user/current'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer $token",
        },
      );
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        if (jsonResponse == null) {
          throw Exception('Empty response from server');
        }

        print('JSON Response: $jsonResponse'); // Debugging

        if (jsonResponse is Map<String, dynamic>) {
          if (jsonResponse.containsKey('id') &&
              jsonResponse.containsKey('email') &&
              jsonResponse.containsKey('roles') &&
              jsonResponse.containsKey('active') &&
              jsonResponse.containsKey('actor') &&
              jsonResponse.containsKey('code')) {
            return User.fromJson(jsonResponse);
          } else {
            throw Exception('Expected keys not found in JSON response');
          }
        } else {
          throw Exception('Unexpected JSON format');
        }
      } else if (response.statusCode == 401) {
        print('Unauthorized access: Check your authentication token.');
        throw Exception('Unauthorized access. Please log in again.');
      } else {
        print('Failed to load user: ${response.statusCode}');
        throw Exception('Failed to load user');
      }
    } catch (e) {
      print('Error fetching user: $e');
      throw Exception('Failed to load user');
    }
  }

  Future<Map<String, dynamic>> fetchUserBalance() async {
    // Ensure _init() is completed before using `token`
    await _init();

    if (token == null) {
      throw Exception('Token is null. Please login again.');
    }

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/user/wallet'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print('Failed to load user balance: ${response.statusCode}');
        throw Exception('Failed to load user balance');
      }
    } catch (e) {
      print('Error fetching user balance: $e');
      throw Exception('Failed to load user balance');
    }
  }
}
