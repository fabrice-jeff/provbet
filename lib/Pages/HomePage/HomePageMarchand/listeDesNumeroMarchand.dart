import 'package:flutter/material.dart';


class Listedesnumeromarchand extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: Text('Les numeros des marchands',style: TextStyle(color: Colors.white,fontSize: 18),),
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.blue.shade900,
        ),
        body: Padding(
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
                          'Nom Prénom',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Numéro de Téléphone',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Pays',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  decoration: BoxDecoration(
                    color: Colors.blue.shade500,
                  ),
                  children: [
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'John Doe',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              '123-456-7890',
                              style: TextStyle(color: Colors.white, fontSize: 12),
                            ),
                            SizedBox(width: 10),
                            // Image.network(
                            //   'https://upload.wikimedia.org/wikipedia/commons/6/6b/WhatsApp.svg',
                            //   width: 2,
                            //   height: 2,
                            // ),
                          ],
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'USA',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  decoration: BoxDecoration(
                    color: Colors.blue.shade300,
                  ),
                  children: [
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Jane Smith',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              '098-765-4321',
                              style: TextStyle(color: Colors.white, fontSize: 12),
                            ),
                            SizedBox(width: 10),
                            // Image.network(
                            //   'https://upload.wikimedia.org/wikipedia/commons/6/6b/WhatsApp.svg',
                            //   width: 20,
                            //   height: 20,
                            //),
                          ],
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Canada',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
  }
}
