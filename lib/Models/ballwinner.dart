import 'package:probet/Models/game.dart';

import '../services/datetime_format.dart';

class Ballwinner {
  final List<dynamic> balls;
  final DateTime? createdAt;
  final Game game;

  Ballwinner({
    required this.balls,
     this.createdAt,
    required this.game,
  });

  factory Ballwinner.fromJson(Map<String, dynamic> json) {
    //print("Bonjour");
    Game game = Game.fromJson(json['game']);
    return Ballwinner(
      balls: List<dynamic>.from(json['balls']),
      createdAt: (json['createdAt']==null)?null: dateTimeFormat(json['createdAt']),
      game: game,
    );
  }
}