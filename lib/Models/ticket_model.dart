import 'package:probet/Models/pari.dart';
import '../services/datetime_format.dart';

class Ticket {
  final String numTicket;
  final List<Bet> bets;
  final DateTime createdAt;
  final String startTime;
  final double amount;

  Ticket({
    required this.numTicket,
    required this.bets,
    required this.createdAt,
    required this.amount,
    required this.startTime,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    List<Bet> bets = [];
    for (var element in json["bets"]) {
      bets.add(Bet.fromJson(element));
    }

    return Ticket(
      numTicket: json['number'],
      bets: bets,
      amount: double.parse(json['amount'].toString()),  // Assurer que c'est un double
      startTime: json['startTime'].toString(),  // Assurer que c'est une chaîne de caractères
      createdAt: dateTimeFormat(json['createdAt']),
    );
  }
}
