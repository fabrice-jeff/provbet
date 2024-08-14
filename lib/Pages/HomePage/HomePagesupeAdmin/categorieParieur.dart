import 'package:flutter/material.dart';

class Parieur {
  final String title;
  final String parieurName;
  final String identifier;

  Parieur({
    required this.title,
    required this.parieurName,
    required this.identifier,
  });
}

class CategorieParieur extends StatefulWidget {
  const CategorieParieur({Key? key}) : super(key: key);

  @override
  State<CategorieParieur> createState() => _CategorieParieurState();
}

class _CategorieParieurState extends State<CategorieParieur> {
  int selectedIndex = 0;

  List<Parieur> DunamiqueOrders = [
    Parieur(title: "parieur 1", parieurName: "GOHOUI Dirranaud ", identifier: "85552"),
    Parieur(title: "parieur 2", parieurName: "HOMEKI Julien ", identifier: "8555"),
    Parieur(title: "parieur 3", parieurName: "GOHOUI François", identifier: "8552"),
  ];
  List<Parieur> Moyenorder = [
    Parieur(title: "parieur 1", parieurName: "GOHOUI Dirranaud ", identifier: "85552"),
    Parieur(title: "parieur 2", parieurName: "HOMEKI Julien ", identifier: "8555"),
    Parieur(title: "parieur 3", parieurName: "GOHOUI François", identifier: "8552"),
  ];
  List<Parieur> Faibleorder = [
    Parieur(title: "parieur 1", parieurName: "GOHOUI Dirranaud ", identifier: "85552"),
    Parieur(title: "parieur 2", parieurName: "HOMEKI Julien ", identifier: "8555"),
    Parieur(title: "parieur 3", parieurName: "GOHOUI François", identifier: "8552"),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, top: 25, bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = 0;
                  });
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Dynamiques",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: selectedIndex == 0 ? FontWeight.bold : FontWeight.normal,
                        color: selectedIndex == 0 ? Colors.blue.shade900 : Colors.black,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Container(
                        height: 3,
                        width: 90,
                        decoration: BoxDecoration(
                          color: selectedIndex == 0 ? Colors.blue.shade900 : Colors.transparent,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = 1;
                  });
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Moyens",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: selectedIndex == 1 ? FontWeight.bold : FontWeight.normal,
                        color: selectedIndex == 1 ? Colors.blue.shade900 : Colors.black,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Container(
                        height: 3,
                        width: 65,
                        decoration: BoxDecoration(
                          color: selectedIndex == 1 ? Colors.blue.shade900 : Colors.transparent,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = 2;
                  });
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Failles",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: selectedIndex == 2 ? FontWeight.bold : FontWeight.normal,
                        color: selectedIndex == 2 ? Colors.blue.shade900 : Colors.black,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Container(
                        height: 3,
                        width: 50,
                        decoration: BoxDecoration(
                          color: selectedIndex == 2 ? Colors.blue.shade900 : Colors.transparent,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: _buildContent(),
        ),
      ],
    );
  }

  Widget _buildContent() {
    if (selectedIndex == 0) {
      return _builddynamiqueOrders();
    } else if (selectedIndex == 1) {
      return _buildOrderMoyen();
    } else {
      return _buildOrderFaible();
    }
  }

  Widget _builddynamiqueOrders() {
    return ListView.builder(
      itemCount: DunamiqueOrders.length,
      itemBuilder: (context, index) {
        final order = DunamiqueOrders[index];
        return Card(
          child: ListTile(
            title: Text(order.title),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Parieur: ${order.parieurName}"),
                Text("Identifiant: ${order.identifier}"),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildOrderMoyen() {
    return ListView.builder(
      itemCount: Moyenorder.length,
      itemBuilder: (context, index) {
        final order = Moyenorder[index];
        return Card(
          child: ListTile(
            title: Text(order.title),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Prieur: ${order.parieurName}"),
                Text("idendifiant: ${order.identifier}"),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildOrderFaible() {
    return ListView.builder(
      itemCount: Faibleorder.length,
      itemBuilder: (context, index) {
        final order = Faibleorder[index];
        return Card(
          child: ListTile(
            title: Text(order.title),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Parieur: ${order.parieurName}"),
                Text("Identifiant: ${order.identifier}"),
              ],
            ),
          ),
        );
      },
    );
  }
}

