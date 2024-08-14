// lib/Models/transaction.dart
import 'dart:convert';

import 'package:probet/Models/user.dart';

class Transaction {
  final int id;
  final int amount;
  final String typeTransaction;
  final String code;
  final DateTime createdAt;
  final User client;
  final User insertBy;

  Transaction({
    required this.id,
    required this.amount,
    required this.typeTransaction,
    required this.code,
    required this.createdAt,
    required this.client,
    required this.insertBy,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {

    User client = User.fromJson(json['client']);
    User insertBy = User.fromJson(json['insert_by']);
    print(json['amount'].runtimeType);
    return Transaction(
      id: json['id'],
      amount: json['amount'],
      client: client,
      insertBy: insertBy,
      typeTransaction: json['typeTransaction'],
      code: json['code'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
