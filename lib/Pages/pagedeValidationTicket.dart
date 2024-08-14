// import 'package:probet/Pages/Historique/page_De_Ticket.dart';
// import 'package:probet/Pages/Profil/profilUtilisateur.dart';
// import '../Models/ticket_model.dart'; // Importer la classe Ticket
// import '../Models/pari.dart'; // Importer la classe Bet
// import 'Boule/selection_Des_boules.dart';
// import 'notification.dart';
// import 'package:flutter/material.dart';
//
// class ValidationDesTicket extends StatefulWidget {
//   final String selectedBetType;
//   final List<int> selectedNumbers;
//   final double betAmount;
//
//   const ValidationDesTicket({
//     Key? key,
//     required this.selectedBetType,
//     required this.selectedNumbers,
//     required this.betAmount,
//   }) : super(key: key);
//
//   @override
//   State<ValidationDesTicket> createState() => _ValidationDesTicketState();
// }
//
// class _ValidationDesTicketState extends State<ValidationDesTicket> {
//   bool _isResetButtonClicked = false;
//   bool _isValidateButtonClicked = false;
//
//   static int ticketCounter = 1;
//   double _totalBetAmount = 0.0;
//   bool _ticketValidated = false;
//   List<Bet> bets = [];
//
//   String generateNumTicket(int hour) {
//     String prefix;
//     if (hour >= 18 || hour < 11) {
//       prefix = 'Fi'; // Fifa
//     } else if (hour >= 11 && hour < 15) {
//       prefix = 'Re'; // Repo
//     } else {
//       prefix = 'Vi'; // Vivi
//     }
//     int radical = ticketCounter++;
//     return '$prefix${radical.toString().padLeft(4, '0')}';
//   }
//
//   void _resetSelection() {
//     setState(() {
//       _isResetButtonClicked = !_isResetButtonClicked;
//     });
//
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => Selection_Des_Boules(
//           onValidation: (type, numbers, amount) {
//             setState(() {
//               if (bets.length < 3) {
//                 Bet bet = Bet(
//                   id: generateNumTicket(DateTime.now().hour),
//                   type_bet: type,
//                   balls: numbers.toList(), // Convert Set<int> to List<int>
//                   amount: amount,
//                 );
//                 bets.add(bet);
//                 _totalBetAmount += amount;
//               }
//             });
//           },
//           onPlayPressed: () {},
//           selectedHour: DateTime.now().hour,
//         ),
//       ),
//     );
//   }
//
//   void _validateSelection() {
//     setState(() {
//       _isValidateButtonClicked = !_isValidateButtonClicked;
//       _ticketValidated = true;
//     });
//
//     String numTicket = generateNumTicket(DateTime.now().hour);
//     Ticket ticket = Ticket(
//       numTicket: numTicket,
//       bets: bets,
//     );
//
//     HistoriqueDesTickets.addTicket(ticket);
//   }
//
//   void _addBet() {
//     if (bets.length < 3) {
//       Bet bet = Bet(
//         id: generateNumTicket(DateTime.now().hour),
//         type_bet: widget.selectedBetType,
//         balls: widget.selectedNumbers,
//         amount: widget.betAmount,
//       );
//       setState(() {
//         bets.add(bet);
//         _totalBetAmount += widget.betAmount;
//       });
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _addBet();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     String numTicket = generateNumTicket(DateTime.now().hour);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Image.asset(
//               'assets/images/logo/newlogo.png',
//               height: 50,
//               width: 50,
//             ),
//           ],
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.notifications, size: 40),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => NotificationPage()),
//               );
//             },
//           ),
//           SizedBox(width: 15),
//           IconButton(
//             icon: ImageIcon(
//               AssetImage('assets/Icones/icons8-user-circle-96.png'),
//               size: 80,
//             ),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => ProfilUtilisateur()),
//               );
//             },
//           ),
//           SizedBox(width: 20),
//         ],
//         backgroundColor: Colors.blue.shade900,
//       ),
//       body: Stack(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage('assets/images/boules.jpg'),
//                 fit: BoxFit.cover,
//                 colorFilter: ColorFilter.mode(
//                   Colors.black.withOpacity(0.2),
//                   BlendMode.dstATop,
//                 ),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 8.0, left: 15, right: 15),
//             child: Container(
//               height: 160,
//               width: 380,
//               decoration: BoxDecoration(
//                 color: Colors.blue.shade900.withOpacity(0.6),
//                 borderRadius: BorderRadius.circular(25.0),
//               ),
//               child: Center(
//                 child: Padding(
//                   padding: const EdgeInsets.all(20.0),
//                   child: Text(
//                     "Avant de valider un ticket, la somme des montants de vos paris doit être supérieure ou égale à 100F CFA. Sinon nous vous demandons de compléter vos paris.",
//                     style: TextStyle(color: Colors.white, fontSize: 18),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(height: 50),
//           Center(
//             child: bets.isEmpty || _ticketValidated
//                 ? Text(
//               "Veuillez consulter l'historique des tickets",
//               style: TextStyle(color: Colors.blueGrey, fontSize: 18),
//             )
//                 : Padding(
//               padding: const EdgeInsets.only(top: 100),
//               child: Container(
//                 color: Colors.blueGrey.shade900.withOpacity(0.6),
//                 width: 300,
//                 height: 370,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Text(
//                       "ID du ticket: $numTicket",
//                       style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white),
//                     ),
//                     SizedBox(height: 10),
//                     SingleChildScrollView(
//                       scrollDirection: Axis.vertical,
//                       child: Stack(
//                         children: [
//                           Card(
//                             elevation: 8,
//                             margin: EdgeInsets.symmetric(horizontal: 20),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(15),
//                             ),
//                             child: Padding(
//                               padding: EdgeInsets.all(20),
//                               child: Column(
//                                 mainAxisSize: MainAxisSize.min,
//                                 crossAxisAlignment:
//                                 CrossAxisAlignment.stretch,
//                                 children: [
//                                   Text(
//                                     "Type de pari: ${widget.selectedBetType}",
//                                     style: TextStyle(
//                                         fontSize: 18,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                   SizedBox(height: 10),
//                                   Column(
//                                     children: bets
//                                         .map((bet) => Column(
//                                       crossAxisAlignment:
//                                       CrossAxisAlignment
//                                           .start,
//                                       children: [
//                                         Text(
//                                           "Numéros sélectionnés: ${bet.balls.join(', ')}",
//                                           style: TextStyle(
//                                               fontSize: 18),
//                                         ),
//                                         Text(
//                                           "Prix du pari: ${bet.amount} F CFA",
//                                           style: TextStyle(
//                                               fontSize: 18),
//                                         ),
//                                       ],
//                                     ))
//                                         .toList(),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     Text(
//                       "Montant total : $_totalBetAmount F CFA",
//                       style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           Positioned(
//             top: 580,
//             left: 15,
//             right: 15,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 OutlinedButton(
//                   onPressed: _resetSelection,
//                   child: Text(
//                     'Completer',
//                     style: TextStyle(
//                       color: _isResetButtonClicked
//                           ? Colors.blue.shade900
//                           : Colors.white70,
//                       fontSize: 20,
//                     ),
//                   ),
//                   style: OutlinedButton.styleFrom(
//                     backgroundColor: _isResetButtonClicked
//                         ? Colors.white
//                         : Colors.blue.shade900,
//                     side: BorderSide(color: Colors.white, width: 2.0),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(18.0),
//                     ),
//                   ),
//                 ),
//                 OutlinedButton(
//                   onPressed:
//                   _totalBetAmount >= 100 ? _validateSelection : null,
//                   child: Text(
//                     'Valider',
//                     style: TextStyle(
//                       color: _isValidateButtonClicked
//                           ? Colors.blue.shade900
//                           : Colors.white70,
//                       fontSize: 20,
//                     ),
//                   ),
//                   style: OutlinedButton.styleFrom(
//                     backgroundColor: _isValidateButtonClicked
//                         ? Colors.white
//                         : Colors.blue.shade900,
//                     side: BorderSide(color: Colors.white, width: 2.0),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(18.0),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:probet/Models/ticket_model.dart';
import 'package:probet/Pages/Profil/Parieur/profilUtilisateur.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/pari.dart';
import 'Boule/selection_Des_boules.dart';
import 'notification.dart';
import 'package:http/http.dart' as http;

class ValidationDesTicket extends StatefulWidget {
  final Ticket ticket;

  const ValidationDesTicket({
    Key? key,
    required this.ticket,
  }) : super(key: key);

  @override
  State<ValidationDesTicket> createState() => _ValidationDesTicketState();
}

class _ValidationDesTicketState extends State<ValidationDesTicket> {
  bool _isResetButtonClicked = false;
  bool _isValidateButtonClicked = false;

  static int ticketCounter = 1;
  bool _ticketValidated = false;
  List<Bet> bets = [];

  String generateNumTicket(int hour) {
    String prefix;
    if (hour >= 18 || hour < 11) {
      prefix = 'Fi'; // Fifa
    } else if (hour >= 11 && hour < 15) {
      prefix = 'Re'; // Repo
    } else {
      prefix = 'Vi'; // Vivi
    }
    int radical = ticketCounter++;
    return '$prefix${radical.toString().padLeft(4, '0')}';
  }

  void _resetSelection() {
    setState(() {
      _isResetButtonClicked = !_isResetButtonClicked;
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Selection_Des_Boules(
          onValidation: (type, numbers, amount) {
            setState(() {
              // if (bets.length < 3) {
              //   Bet bet = Bet(
              //     id: generateNumTicket(DateTime.now().hour),
              //     type_bet: type,
              //     balls: numbers.toList(), // Convert Set<int> to List<int>
              //     amount: amount,
              //   );
              //   bets.add(bet);
              //   _totalBetAmount += amount;
              // }
            });
          },
          onPlayPressed: () {},
          selectedHour: DateTime.now().hour,
          numeroTicket: widget.ticket.numTicket,
        ),
      ),
    );
  }

  void _validateSelection() async {
    await _validateTicket(widget.ticket.numTicket);
    setState(() {
      _isValidateButtonClicked = !_isValidateButtonClicked;
      _ticketValidated = true;
    });
  }

  @override
  void initState() {
    super.initState();
    bets = widget.ticket.bets; // Initialize bets from the ticket object
  }

  Future<Map<String, dynamic>> _validateTicket(String numTicket) async {
    final url =
        Uri.parse('https://provbet.com/api/user/draw/validate/$numTicket');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer $token",
        },
        body: null,
      );
      if (response.statusCode == 200) {
        print(jsonDecode(response.body));
        return jsonDecode(response.body);
      } else {
        print(response.statusCode);
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
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/images/logo/newlogo.png',
              height: 50,
              width: 50,
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, size: 40,color: Colors.white,),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationPage()),
              );
            },
          ),
          SizedBox(width: 15),
          IconButton(
            icon: ImageIcon(
              AssetImage('assets/Icones/icons8-user-circle-96.png'),
              size: 80,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilUtilisateur()),
              );
            },
          ),
          SizedBox(width: 20),
        ],
        backgroundColor: Colors.blue.shade900,
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
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 15, right: 15),
            child: Container(
              height: 160,
              width: 380,
              decoration: BoxDecoration(
                color: Colors.blue.shade900.withOpacity(0.6),
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Avant de valider un ticket, la somme des montants de vos paris doit être supérieure ou égale à 100F CFA. Sinon nous vous demandons de compléter vos paris.",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 50),
          Center(
            child: bets.isEmpty || _ticketValidated
                ? Text(
                    "Veuillez consulter l'historique des tickets",
                    style: TextStyle(color: Colors.blueGrey, fontSize: 18),
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Container(
                      color: Colors.orange.shade50,
                      width: 300,
                      height: 370,
                      child: SingleChildScrollView(
                       scrollDirection: Axis.vertical,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "ID du ticket: ${widget.ticket.numTicket}",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue.shade900),
                            ),
                            SizedBox(height: 10),
                            SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Stack(
                                children: [
                                  for (var bet in widget.ticket.bets)
                                    Card(
                                      elevation: 8,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(20),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            // Text(
                                            //   "Type de pari: ${bet.type}",
                                            //   style: TextStyle(
                                            //       fontSize: 18,
                                            //       fontWeight: FontWeight.bold),
                                            // ),
                                            // SizedBox(height: 10),
                                            Column(
                                              children: bets
                                                  .map((bet) => SingleChildScrollView(
                                                   scrollDirection: Axis.vertical,
                                                    child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "Type de pari: ${bet.type.name}",
                                                              style: TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight: FontWeight.bold),
                                                            ),
                                                            SizedBox(height: 10),
                                                            Text(
                                                              "Numéros sélectionnés: ${bet.balls.join(', ')}",
                                                              style: TextStyle(
                                                                  fontSize: 18),
                                                            ),
                                                            Text(
                                                              "Prix du pari: ${bet.amount} F CFA",
                                                              style: TextStyle(
                                                                  fontSize: 18),
                                                            ),
                                                          ],
                                                        ),
                                                  ))
                                                  .toList(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              "Montant total : ${widget.ticket.amount} F CFA",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue.shade900),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
          ),
          Positioned(
            top: 580,
            left: 15,
            right: 15,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: _resetSelection,
                  child: Text(
                    'Completer',
                    style: TextStyle(
                      color: _isResetButtonClicked
                          ? Colors.blue.shade900
                          : Colors.white70,
                      fontSize: 20,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: _isResetButtonClicked
                        ? Colors.white
                        : Colors.blue.shade900,
                    side: BorderSide(color: Colors.white, width: 2.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                ),
                OutlinedButton(
                  onPressed:
                      widget.ticket.amount >= 100 ? _validateSelection : null,
                  child: Text(
                    'Valider',
                    style: TextStyle(
                      color: _isValidateButtonClicked
                          ? Colors.blue.shade900
                          : Colors.white70,
                      fontSize: 20,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: _isValidateButtonClicked
                        ? Colors.white
                        : Colors.blue.shade900,
                    side: BorderSide(color: Colors.white, width: 2.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
