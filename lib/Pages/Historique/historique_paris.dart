import 'package:flutter/material.dart';
import 'package:probet/Models/ballwinner.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/constantesStatutPari.dart';

class HistoriquePari extends StatefulWidget {
  const HistoriquePari({Key? key}) : super(key: key);

  @override
  State<HistoriquePari> createState() => _HistoriquePariState();
}

class _HistoriquePariState extends State<HistoriquePari> {
  List<Ballwinner> ballWinners = [];
  bool isLoading = true;


  @override
  void initState() {
    super.initState();
    _fetchBallWinners();
  }

  Future<void> _fetchBallWinners() async {
    final url = Uri.parse('https://provbet.com/api/user/draw/history');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.get(url, headers: headers);
      print(response.statusCode);
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);
        List<Ballwinner> fetchedBallWinners = jsonResponse.map((data) => Ballwinner.fromJson(data)).toList();
        setState(() {
          ballWinners = fetchedBallWinners;
          isLoading = false;
        });
      } else {
        print("Error: ${response.statusCode}");
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print("Network error: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget answers(DateTime? createdAt, List<dynamic> bets) {
    if (bets.isEmpty) {
      return SizedBox.shrink();
    }

    return Column(
      children: bets.map<Widget>((bet) {
        List<int> balls = List<int>.from(bet['balls']);
        double? gain = bet['gain'];
        String typeBetName = bet['typeBet']['name'];
       // List<int> balls = List<int>.from(bet['balls']);
        //double? gain = bet['gain'];
        //String typeBetName = bet['typeBet']['name'];


        // Déterminer le statut du pari
        String status;
        if (gain != null) {
          status = STATUS_BET_WIN;  // Gagné
        } else {
          status = STATUS_BET_LOST;  // Perdu
        }

        // Texte d'affichage du statut
        String displayStatus = status == STATUS_BET_WIN ? "Gagné" : "Perdu";

        return Card(
          color: Colors.orange.shade50,
          child: ExpansionTile(
            title: Text(
              'Date: ${createdAt?.toLocal().toString() ?? "N/A"}',
              style: TextStyle(
                color: Colors.blue.shade900,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Text(
                  'Type de Pari: $typeBetName',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Text(
                  'Boules Gagnantes: ${balls.join(', ')}',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Text(
                  'Statut: $displayStatus',
                  style: TextStyle(
                    color: status == STATUS_BET_WIN ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: Center(child: Text('Historique des paris', style: TextStyle(color: Colors.white))),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/boules.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.2),
                  BlendMode.dstATop,
                ),
              ),
            ),
          ),
          if (isLoading) Center(child: CircularProgressIndicator()) else Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: ListView.builder(
              itemCount: ballWinners.length,
              itemBuilder: (context, index) {
                Ballwinner ballwinner = ballWinners[index];
                return answers(
                  ballwinner.createdAt,
                  ballwinner.balls, // Passer la liste des paris
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
