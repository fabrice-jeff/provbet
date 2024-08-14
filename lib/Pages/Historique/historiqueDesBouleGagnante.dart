// import 'package:flutter/material.dart';
// import 'package:probet/Models/ballwinner.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// import 'package:shared_preferences/shared_preferences.dart';
//
// class HistoriqueDesBouleGagnante extends StatefulWidget {
//   const HistoriqueDesBouleGagnante({Key? key}) : super(key: key);
//
//   @override
//   State<HistoriqueDesBouleGagnante> createState() => _HistoriqueDesBouleGagnanteState();
// }
//
// class _HistoriqueDesBouleGagnanteState extends State<HistoriqueDesBouleGagnante> {
//   List<Ballwinner> ballWinners = [];
//   bool isLoading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchBallWinners();
//   }
//
//   Future<void> _fetchBallWinners() async {
//     final url = Uri.parse('https://provbet.com/api/game/history_winner_balls');
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? token = prefs.getString('token');
//
//     final headers = {
//       'Content-Type': 'application/json',
//       'Authorization': 'Bearer $token',
//     };
//
//     try {
//       final response = await http.get(url, headers: headers);
//       print(response.statusCode);
//       if (response.statusCode == 200) {
//         List<dynamic> jsonResponse = jsonDecode(response.body);
//         List<Ballwinner> fetchedBallWinners = jsonResponse.map((data) => Ballwinner.fromJson(data)).toList();
//         setState(() {
//           ballWinners = fetchedBallWinners;
//           isLoading = false;
//         });
//       } else {
//         print("Error: ${response.statusCode}");
//         setState(() {
//           isLoading = false;
//         });
//       }
//     } catch (e) {
//       print("Network error: $e");
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }
//
//   Widget answers(DateTime? createdAt, List<dynamic> balls) {
//     return Column(
//       children: [
//         Column(
//           children: [
//             Row(
//               children: [
//                 Expanded(
//                   child: Card(
//                     color: Colors.orange.shade50,
//                     child: ExpansionTile(
//                       title: Text(
//                         'Date: ${createdAt?.toLocal().toString() ?? "N/A"}',  // Display the createdAt DateTime, or "N/A" if null
//                         style: TextStyle(
//                           color: Colors.blue.shade900,
//                           fontSize: 15,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(left: 25),
//                           child: Text(
//                             'Boules Gagnantes: ${balls.join(', ')}',  // Convert the list of balls to a string separated by commas
//                           ),
//                         ),
//                         SizedBox(height: 10)
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ],
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
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
//           isLoading
//               ? Center(child: CircularProgressIndicator())
//               : Padding(
//             padding: const EdgeInsets.only(top: 15.0),
//             child: ListView.builder(
//               itemCount: ballWinners.length,
//               itemBuilder: (context, index) {
//                 Ballwinner ballwinner = ballWinners[index];
//                 return answers(
//                   ballwinner.createdAt,  // Use createdAt from the fetched data
//                   ballwinner.balls, // Pass the list of winning balls
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
import 'package:flutter/material.dart';
import 'package:probet/Models/ballwinner.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class HistoriqueDesBouleGagnante extends StatefulWidget {
  const HistoriqueDesBouleGagnante({Key? key}) : super(key: key);

  @override
  State<HistoriqueDesBouleGagnante> createState() => _HistoriqueDesBouleGagnanteState();
}

class _HistoriqueDesBouleGagnanteState extends State<HistoriqueDesBouleGagnante> {
  List<Ballwinner> ballWinners = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchBallWinners();
  }

  Future<void> _fetchBallWinners() async {
    final url = Uri.parse('https://provbet.com/api/game/history_winner_balls');
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

  Widget answers(DateTime? createdAt, List<dynamic> balls) {
    // Only display the ExpansionTile if balls are not empty
    if (balls.isEmpty) {
      return SizedBox.shrink();  // Return an empty widget
    }

    return Column(
      children: [
        Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Card(
                    color: Colors.orange.shade50,
                    child: ExpansionTile(
                      title: Text(
                        'Date: ${createdAt?.toLocal().toString() ?? "N/A"}',  // Display the createdAt DateTime, or "N/A" if null
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
                            'Boules Gagnantes: ${balls.join(', ')}',  // Convert the list of balls to a string separated by commas
                          ),
                        ),
                        SizedBox(height: 10)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          isLoading
              ? Center(child: CircularProgressIndicator())
              : Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: ListView.builder(
              itemCount: ballWinners.length,
              itemBuilder: (context, index) {
                Ballwinner ballwinner = ballWinners[index];
                return answers(
                  ballwinner.createdAt,  // Use createdAt from the fetched data
                  ballwinner.balls,      // Pass the list of winning balls
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

