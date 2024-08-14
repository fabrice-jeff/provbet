import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:probet/Models/ticket_model.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Importer la classe Ticket

class HistoriqueDesTickets extends StatefulWidget {
  static final List<Ticket> _tickets = [];

  // Méthode pour ajouter un ticket à l'historique
  static void addTicket(Ticket ticket) {
    _tickets.add(ticket);
  }

  static List<Ticket> getTickets() {
    return _tickets;
  }

  const HistoriqueDesTickets({Key? key}) : super(key: key);

  @override
  State<HistoriqueDesTickets> createState() => _HistoriqueDesTicketsState();
}

class _HistoriqueDesTicketsState extends State<HistoriqueDesTickets> {
  Future<dynamic> _getTicket() async {
    final url = Uri.parse('https://provbet.com/api/draw/history');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token');

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer $token",
        },
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Erreur serveur. Veuillez réessayer plus tard.');
      }
    } catch (e) {
      print(e);
      throw Exception('Une erreur s\'est produite: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
          future: _getTicket(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              List<Ticket> tickets = [];
              for (var element in snapshot.data) {
                element['draw']['startTime'] = "15";
                element['draw']['bets'] = element['bets'];
                double amount = 0;
                for (var bet in element['draw']['bets']) {
                  amount += bet['amount'];
                }
                element['draw']['amount'] = amount.toString();
                Ticket ticket = Ticket.fromJson(element['draw']);
                tickets.add(ticket);
              }

              return Stack(
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
                  ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      final ticket = snapshot.data[index];
                      return Card(
                        elevation: 8,
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Container(
                            color: Colors.orange.shade50,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "ID du ticket: ${tickets[index].numTicket}",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue.shade900),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Type de pari: ${tickets[index].bets.map((bet) => bet.type.name).join(', ')}",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue.shade900),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Numéros sélectionnés: ${tickets[index].bets.map((bet) => bet.balls.join(', ')).join(' | ')}",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.blue.shade900),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Prix du pari: ${tickets[index].bets.map((bet) => bet.amount).reduce((a, b) => a + b)} F CFA",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.blue.shade900),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );
            }
          },
        ));
  }
}
