import 'package:flutter/material.dart';
import 'package:probet/Pages/Autentification/pagedeConnexion.dart';// Importez la page de connexion
import 'package:probet/Pages/HomePage/HomePageParieur/homePage.dart';
import 'package:probet/Pages/Profil/Parieur/profilUtilisateur.dart';
import 'package:probet/faq.dart';
import 'Pages/Boule/selection_Des_boules.dart';
import 'Pages/Historique/historiqueDesBouleGagnante.dart';
import 'Pages/Historique/historique_Translation_Client.dart';
import 'Pages/Historique/historique_paris.dart';
import 'Pages/Historique/page_De_Ticket.dart';
import 'Pages/HomePage/HomePageMarchand/listeDesNumeroMarchand.dart';
import 'Pages/notification.dart'; // Importez la page de notification
import 'Pages/pays_du_Jeu.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoggedIn = false; // État de la connexion

  void _loginSuccess() {
    setState(() {
      _isLoggedIn = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => _isLoggedIn
            ? HomePageWrapper()
            : PageDeConnexion(onLoginSuccess: _loginSuccess),
        '/pays_du_Jeu': (context) =>
            Pays_DansLeguel_JeuDisponible(onBouleTap: () {}),
        '/selection_Des_boules': (context) => Selection_Des_Boules(
          onPlayPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HistoriqueDesTickets()),
            );
          },
          onValidation: (String type, Set<int> numbers, double amount) {
            // Ajoutez votre logique de validation ici
          },
          selectedHour:
          0, // Remplacez null par une valeur d'heure valide (par exemple 0)
        ),
        '/notifications': (context) => NotificationPage(),
        '/profilUtilisateur': (context) =>
            ProfilUtilisateur(), // Assurez-vous que cette route est correcte
        '/historiquedeTranslationClient': (context) =>
            HistoriquedeTranslationClient(),
       '/listedesnumeromarchand': (context) => Listedesnumeromarchand(),
        '/historiquePari': (context) => HistoriquePari(),
        '/faq': (context) =>FAQPage(),

      },
    );
  }
}

class HomePageWrapper extends StatefulWidget {
  @override
  _HomePageWrapperState createState() => _HomePageWrapperState();
}

class _HomePageWrapperState extends State<HomePageWrapper> {
  int _currentIndex = 0;

  void setCurrentIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/images/logo/newlogo.png',
              height: 70,
              width: 100,
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, size: 40,color: Colors.white,),
            onPressed: () {
              Navigator.pushNamed(context, '/notifications');
            },
          ),
          SizedBox(width: 25),
          IconButton(
            icon: ImageIcon(
              AssetImage('assets/Icones/icons8-user-circle-96.png'),
              size: 80,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/profilUtilisateur');
            },
          ),
          SizedBox(width: 20),
        ],
      ),
      body: [
        HomePage(onPlayPressed: () => setCurrentIndex(1)),
        Pays_DansLeguel_JeuDisponible(onBouleTap: () {}),
        HistoriqueDesTickets(),
        HistoriqueDesBouleGagnante(),
      ][_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setCurrentIndex(index);
        },
        backgroundColor: Colors.blue.shade900,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.white,
        iconSize: 30,
        elevation: 10,
        selectedLabelStyle: TextStyle(fontSize: 15),
        unselectedLabelStyle: TextStyle(fontSize: 15),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Pays',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/Icones/IconTicket.png'),
              size: 50,
            ),
            label: 'Ticket',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/Icones/IconHistorique.png'),
              size: 50,
            ),
            label: 'Historique',
          ),
        ],
      ),
    );
  }
}

