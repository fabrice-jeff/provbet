// lib/Pages/Home_marchandwrapper.dart
import 'package:flutter/material.dart';
import 'package:probet/Pages/Profil/Marchand/profilMarchant.dart';
import 'package:probet/Pages/notification.dart';
import '../../../Models/translation.dart';
import '../../../services/constantstypesTransaction.dart';
import '../../../services/transaction_service.dart';

class Home_marchandwrapper extends StatefulWidget {
  @override
  State<Home_marchandwrapper> createState() => _Home_marchandwrapperState();
}

class _Home_marchandwrapperState extends State<Home_marchandwrapper> {

  @override
  void initState() {
    super.initState();
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
            icon: Icon(Icons.notifications, size: 40, color: Colors.white),
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
                MaterialPageRoute(builder: (context) => ProfilMarchand()),
              );
            },
          ),
          SizedBox(width: 20),
        ],
        backgroundColor: Colors.blue.shade900,
      ),
      body: FutureBuilder<dynamic>(
        future: TransactionService.getTransactionHistory(),
        builder: (context, snapshot) {
          print(snapshot.data);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print(snapshot.error);
            print(snapshot.runtimeType);
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No transactions found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final transaction = snapshot.data![index];
                String transactionType;

                // Determine the transaction type based on the constants
                if (transaction.typeTransaction == TYPE_TRANSACTION_DEPOSIT) {
                  transactionType = 'Dépôt';
                } else if (transaction.typeTransaction ==
                    TYPE_TRANSACTION_WITHDRAW) {
                  transactionType = 'Retrait';
                } else {
                  transactionType = 'Unknown';
                }

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 110,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade900,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${transaction.createdAt.toLocal()}'.split(' ')[0],
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Client: ${transaction.client.firstName} ${transaction.client.lastName}',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Type: $transactionType', // Display the translated transaction type
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                          Text(
                            'Amount: ${transaction.amount} FCFA',
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
