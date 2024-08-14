import 'package:flutter/material.dart';

class FAQPage extends StatefulWidget {
  const FAQPage({Key? key}) : super(key: key);

  @override
  State<FAQPage> createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("FAQ",style: TextStyle(color: Colors.white),)),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.blue.shade900,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text("Il en existe 5. Le pari sur 1 numéro Pboule1 ; le pari sur 2 numéros Pboule2 ; le pari sur 3 numéros Pboule3 ; le pari sur 4 numéros Pboule4 et le pari sur 5 numéros Pboule5. Pour gagner au Pari Simple, il faut que tous les numéros pronostiqués par le parieur se retrouvent parmi les numéros tirés au sort. La mise de base est de 100F.1- Lorsque vous jouez un seul numéro (Pboule1) très sûr qui vient en première position (donc au premier poteau) vous gagnez 4.500f CFA avec 100f seulement de mise sur ce seul numéro. Pour 200f vous avez 9.000f CFA. Dans le cas contraire, si le seul numéro joué à 100f ne vient pas en première position, vous gagnez 250f. Si vous le jouez à 200f vous gagnez, 500f. En gros vous avez un lot de consolation dépassant le double de votre mise si le numéro joué ne vient pas au premier poteau (en première position) après le résultat. Avec la Providence , vous êtes toujours gagnant !2- Lorsque vous misez 100f sur deux numéros très sûrs (Pboule2) et les deux viennent peu importe l’ordre après le tirage, vous gagnez 25.000f CFA. Et avec 200f vous gagnez 50.000f CFA ;3- Lorsque vous misez 100f sur 3 numéros (Pboule3) très sûrs vous gagnez 250.000f CFA peu importe l’ordre lorsque vous trouvez les 3 numéros après le tirage. Si c’est 200f dans ce cas vous gagnez 500.000f CFA ;4- Lorsque vous misez 100f sur 4 numéros (Pboule4) très sûrs, vous gagnez 750.000f CFA peu importe l’ordre lorsque vous trouvez les 4 numéros après le tirage. Si c’est 200f dans ce cas vous gagnez 1.500.000f CFA 5- Lorsque vous misez 100f sur 5 numéros (Pboule5) très sûrs, vous gagnez quatre millions cinq cent (4.500.000f) francs CFA peu importe l’ordre lorsque vous trouvez les 5 numéros après le tirage. Si c’est 200f dans ce cas vous gagnez neuf millions (9.000.000f) francs CFAB- Les Paris Tchigan (1, 2, 3, 4, 5) ?un numéro. Bloquer, c’est jouer un seul numéro à 890f pour gagner 10.000fcfa peu importe l'ordre d'arrivée ou jouez-le à 1.780f CFA pour gagner 20.000f CFA. Vos numéros de chances : choisissez-les de 1 à 9"),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}







