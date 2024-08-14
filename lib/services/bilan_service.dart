
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/translation.dart';

class BilanService {
  static Future<dynamic> getBetByPeriod(String period) async {
    // URL for the API endpoint
    final url = Uri.parse('https://provbet.com/api/user/balance_sheet_by_period');
    // Retrieve the token from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    List<Transaction> transactions = [];

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    // Send the GET request with headers
    final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode({'period': period})
    );
    // Handle the response
    if (response.statusCode == 200) {
      var  jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } else {
      throw Exception(
          'Failed to load transaction history: ${response.reasonPhrase}');
    }
  }

  static Future<dynamic> getBilanGeneral() async {
    // URL for the API endpoint
    final url = Uri.parse('https://provbet.com/api/user/balance_sheet_general');
    // Retrieve the token from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    List<Transaction> transactions = [];

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    // Send the GET request with headers
    final response = await http.get(
        url,
        headers: headers,
    );
    // Handle the response
    if (response.statusCode == 200) {
      var  jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } else {
      throw Exception(
          'Failed to load transaction history: ${response.reasonPhrase}');
    }
  }
}
