
import '../services/datetime_format.dart';

class Game {
  final int id;
  final DateTime startAt;
  final DateTime endAt;
  final String code;

  Game({
    required this.id,
    required this.startAt,
    required this.endAt,
   required this.code,
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      id: json['id'],
      startAt: dateTimeFormat(json['startAt']),
      endAt: dateTimeFormat(json['endAt']),
      code: json['code'],
    );
  }
}
