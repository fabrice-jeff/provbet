import 'package:probet/Models/typeBet.dart';

import '../services/datetime_format.dart';

class Bet {
  final Typebet type;
  final List<dynamic> balls;
  final double amount;
  final DateTime createdAt;

  Bet({
    required this.type,
    required this.balls,
    required this.amount,
    required this.createdAt,
  });

  factory Bet.fromJson(Map<String, dynamic> json) {
    Typebet typebet=Typebet.fromJson(json['typeBet']);
    print(json['amount'].runtimeType);
    return Bet(
      type: typebet,
      balls: (json['balls'] as List<dynamic>).map((e) => e as int).toList(),
      amount: json['amount'],
      createdAt: dateTimeFormat(json['createdAt']),
    );
  }
}
