import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Notifications",style: TextStyle(color: Colors.white),)),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.blue.shade900,
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Notifications("Les paris de 11h sont fermés"),
                Notifications("Les résultats de 18h sont disponibles"),
                Notifications("Bravo vous avez reçu 1000F CFA comme bonus de paris"),
                Notifications("Les résultats de 14h seront disponibles dans 10 min"),
                Notifications("L'heure de paris de 11h est sonnée"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Notifications extends StatelessWidget {
  final String text;

  const Notifications(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("• ", style: TextStyle(fontSize: 30, color:Colors.black)),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}






