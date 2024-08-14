// lib/Services/transaction_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/translation.dart'; // Assuming you meant 'transaction.dart' instead of 'translation.dart'

class TransactionService {
  static Future<List<Transaction>> getTransactionHistory() async {
    // URL for the API endpoint
    final url = Uri.parse('https://provbet.com/api/user/transaction/history');

    // Retrieve the token from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    List<Transaction> transactions = [];

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token', // Token added here
    };
    // Send the GET request with headers
    final response = await http.get(url, headers: headers);

    // Handle the response
    if (response.statusCode == 200) {
      // List<dynamic> body = jsonDecode(response.body);
      List<dynamic> jsonResponse = jsonDecode(response.body);
      for (var element in jsonResponse) {
        try {
          Transaction transaction = Transaction.fromJson(element);
          transactions.add(transaction);
        } catch (e) {
          print('Erreur lors de la désérialisation de la transaction : $e');
        }
      }
      return transactions;
    } else {
      throw Exception(
          'Failed to load transaction history: ${response.reasonPhrase}');
    }
  }
}
