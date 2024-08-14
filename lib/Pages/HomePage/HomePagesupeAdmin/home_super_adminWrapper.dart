import 'package:flutter/material.dart';
import 'package:probet/Pages/Boule/annonceResultatboulegagnante.dart';
import 'package:probet/Pages/HomePage/HomePagesupeAdmin/categorieParieur.dart';
import 'package:probet/Pages/HomePage/HomePagesupeAdmin/historiquedesTicketvendu.dart';
import 'package:probet/Pages/HomePage/HomePagesupeAdmin/home_super_admin.dart';
import 'package:probet/Pages/HomePage/HomePagesupeAdmin/translationDesMarchand.dart';
import 'package:probet/Pages/notification.dart';
import '../../Profil/superAdmin/profilesuperAdmin.dart';

class HomeSuperAdminwrapper extends StatefulWidget {
  @override
  State<HomeSuperAdminwrapper> createState() => _HomeSuperAdminwrapperState();
}

class _HomeSuperAdminwrapperState extends State<HomeSuperAdminwrapper> {
  int _currentIndex1 = 0;

  void setCurrentIndex(int index) {
    setState(() {
      _currentIndex1 = index;
    });
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
                MaterialPageRoute(builder: (context) => Profilesuperadmin()),
              );
            },
          ),
          SizedBox(width: 20),
        ],
        backgroundColor: Colors.blue.shade900,
      ),
      body: [
        HomeSuperAdmin(),
        CategorieParieur(),
        Historiquedesticketvendu(),
        Translationdesmarchand(),
        Annonceresultatboulegagnante()
      ][_currentIndex1],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex1,
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
            icon: Icon(Icons.play_lesson_sharp),
            label: 'Parieur',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/Icones/IconTicket.png'),
              size: 50,
            ),
            label: 'Ticket',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: 'Marchand',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.question_answer_outlined),
            label: 'Resultat',
          ),
        ],
      ),
    );
  }
}
