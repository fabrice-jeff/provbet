import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../Models/translation.dart';
import '../../../services/constantstypesTransaction.dart';
import '../../../services/contantsRole.dart';
import '../../../services/transaction_service.dart';
class Translationdesmarchand extends StatefulWidget {
  const Translationdesmarchand({Key? key}) : super(key: key);

  @override
  State<Translationdesmarchand> createState() => _TranslationdesmarchandState();
}

class _TranslationdesmarchandState extends State<Translationdesmarchand> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<dynamic>(
        future: TransactionService.getTransactionHistory(),
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print(snapshot.error);
            print(snapshot.runtimeType);
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No transactions found'));
          } else {
            List<Transaction> transactions = snapshot.data;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.blue,
                child: Table(
                  border: TableBorder.all(color: Colors.white),
                  children: [
                    TableRow(
                      decoration: BoxDecoration(
                        color: Colors.blue.shade700,
                      ),
                      children: [
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Identifiant',
                              style: TextStyle(color: Colors.white, fontSize: 8),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Statut',
                              style: TextStyle(color: Colors.white, fontSize: 8),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Nom ',
                              style: TextStyle(color: Colors.white, fontSize: 8),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              ' Depôt',
                              style: TextStyle(color: Colors.white, fontSize: 8),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              ' Retrait',
                              style: TextStyle(color: Colors.white, fontSize: 8),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Montant',
                              style: TextStyle(color: Colors.white, fontSize: 8),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Client id',
                              style: TextStyle(color: Colors.white, fontSize: 8),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Date',
                              style: TextStyle(color: Colors.white, fontSize: 8),
                            ),
                          ),
                        ),
                      ],
                    ),
                    for(Transaction transaction in transactions)
                    TableRow(
                      decoration: BoxDecoration(
                        color: Colors.blue.shade500,
                      ),
                      children: [
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              transaction.insertBy.identifier,
                              style: TextStyle(color: Colors.white, fontSize: 8),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              (transaction.insertBy.roles == ROLE_ASSISTANT_ADMIN)? "Assistant" : (transaction.insertBy.roles == ROLE_SUPER_ADMIN)? "Admin" : "Marchant",
                              style: TextStyle(color: Colors.white, fontSize: 8),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "${transaction.insertBy.lastName} ${transaction.insertBy.firstName}" ,
                              style: TextStyle(color: Colors.white, fontSize: 8),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              (transaction.typeTransaction == TYPE_TRANSACTION_DEPOSIT)? "oui": "",
                              style: TextStyle(color: Colors.white, fontSize: 8),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              (transaction.typeTransaction == TYPE_TRANSACTION_WITHDRAW)? "oui": "",
                              style: TextStyle(color: Colors.white, fontSize: 8),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              transaction.amount.toString(),
                              style: TextStyle(color: Colors.white, fontSize: 8),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              transaction.client.identifier,
                              style: TextStyle(color: Colors.white, fontSize: 8),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              DateFormat('dd/MM/yyyy').format(transaction.createdAt),
                              style: TextStyle(color: Colors.white, fontSize: 8),
                            ),
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
