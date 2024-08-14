import 'package:flutter/material.dart';
import 'package:probet/Pages/Autentification/pagedeConnexion.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../services/constantstypesTransaction.dart';

class Profilesuperadmin extends StatefulWidget {
  const Profilesuperadmin({Key? key}) : super(key: key);

  @override
  State<Profilesuperadmin> createState() => _ProfilesuperadminState();
}

class _ProfilesuperadminState extends State<Profilesuperadmin> {


  //Nomination Assistant

  Future<void> _nominateAssistantAdmin(String identifier, String email) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token'); // Retrieve the token

    final url = Uri.parse('https://provbet.com/api/user/appoint/assistant');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Add the token to the headers
      },
      body: json.encode({'identifier': identifier, 'email': email}),
    );

    if (response.statusCode == 200) {
      print('Nomination successful');
    } else {
      print('Failed to nominate: ${response.body}');
    }
  }



  //Nomination d'un Marchand
  Future<void> _nominateMerchant(String identifier, String email) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token'); // Retrieve the token

    final url = Uri.parse('https://provbet.com/api/user/appoint/marchant');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Add the token to the headers
      },
      body: json.encode({'identifier': identifier, 'email': email}),
    );

    if (response.statusCode == 200) {
      print('Nomination successful');
    } else {
      print('Failed to nominate: ${response.body}');
    }
  }


// Fonction pour effectuer une transaction
  Future<void> _makeTransaction(String identifier, String amount, String typeTransaction) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token'); // Récupère le token

    final url = Uri.parse('https://provbet.com/api/user/transaction');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Ajoute le token aux headers
      },
      body: json.encode({'identifier': identifier, 'amount': amount, 'type_transaction': typeTransaction}),
    );

    if (response.statusCode == 200) {
      print('Transaction successful');
    } else {
      print('Failed to make transaction: ${response.body}');
    }
  }


// Fonction pour afficher le dialogue de recharge pour un Assistant
  void _showRechargeAssistantDialog(BuildContext context, String title) {
    final TextEditingController identifierController = TextEditingController();
    final TextEditingController amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: identifierController,
                decoration: InputDecoration(
                  labelText: "Identifiant",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: amountController,
                decoration: InputDecoration(
                  labelText: "Montant",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Annuler"),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue.shade900,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _makeTransaction(
                  identifierController.text,
                  amountController.text,
                  TYPE_TRANSACTION_DEPOSIT,
                );
                Navigator.of(context).pop();
              },
              child: Text("Recharger"),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue.shade900,
              ),
            ),
          ],
        );
      },
    );
  }

  // Fonction pour afficher le dialogue de retrait pour un Assistant
  void _showRetraitAssistantDialog(BuildContext context, String title) {
    final TextEditingController identifierController = TextEditingController();
    final TextEditingController amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: identifierController,
                decoration: InputDecoration(
                  labelText: "Identifiant",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: amountController,
                decoration: InputDecoration(
                  labelText: "Montant",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Annuler"),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue.shade900,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _makeTransaction(
                  identifierController.text,
                  amountController.text,
                  TYPE_TRANSACTION_WITHDRAW,
                );
                Navigator.of(context).pop();
              },
              child: Text("Retirer"),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue.shade900,
              ),
            ),
          ],
        );
      },
    );
  }

  // Fonction pour afficher le dialogue de recharge pour un marchand
  void _showRechargeMarchandDialog(BuildContext context, String title) {
    final TextEditingController identifierController = TextEditingController();
    final TextEditingController amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: identifierController,
                decoration: InputDecoration(
                  labelText: "Identifiant",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: amountController,
                decoration: InputDecoration(
                  labelText: "Montant",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Annuler"),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue.shade900,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _makeTransaction(
                  identifierController.text,
                  amountController.text,
                  TYPE_TRANSACTION_DEPOSIT,
                );
                Navigator.of(context).pop();
              },
              child: Text("Recharger"),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue.shade900,
              ),
            ),
          ],
        );
      },
    );
  }

  // Fonction pour afficher le dialogue de retrait pour un marchand
  void _showRetraitMarchandDialog(BuildContext context, String title) {
    final TextEditingController identifierController = TextEditingController();
    final TextEditingController amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: identifierController,
                decoration: InputDecoration(
                  labelText: "Identifiant",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: amountController,
                decoration: InputDecoration(
                  labelText: "Montant",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Annuler"),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue.shade900,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _makeTransaction(
                  identifierController.text,
                  amountController.text,
                  TYPE_TRANSACTION_WITHDRAW,
                );
                Navigator.of(context).pop();
              },
              child: Text("Retirer"),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue.shade900,
              ),
            ),
          ],
        );
      },
    );
  }

  // Fonction pour afficher le dialogue de recharge pour un client
  void _showRechargeClientDialog(BuildContext context, String title) {
    final TextEditingController identifierController = TextEditingController();
    final TextEditingController amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: identifierController,
                decoration: InputDecoration(
                  labelText: "Identifiant",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: amountController,
                decoration: InputDecoration(
                  labelText: "Montant",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Annuler"),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue.shade900,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _makeTransaction(
                  identifierController.text,
                  amountController.text,
                  TYPE_TRANSACTION_DEPOSIT,
                );
                Navigator.of(context).pop();
              },
              child: Text("Recharger"),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue.shade900,
              ),
            ),
          ],
        );
      },
    );
  }

  // Fonction pour afficher le dialogue de retrait pour un client
  void _showRetraitClientDialog(BuildContext context, String title) {
    final TextEditingController identifierController = TextEditingController();
    final TextEditingController amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: identifierController,
                decoration: InputDecoration(
                  labelText: "Identifiant",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: amountController,
                decoration: InputDecoration(
                  labelText: "Montant",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Annuler"),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue.shade900,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _makeTransaction(
                  identifierController.text,
                  amountController.text,
                  TYPE_TRANSACTION_WITHDRAW,
                );
                Navigator.of(context).pop();
              },
              child: Text("Retirer"),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue.shade900,
              ),
            ),
          ],
        );
      },
    );
  }

  void _showNominationAssistantDialog(BuildContext context, String title) {
    final TextEditingController emailController1 = TextEditingController();
    final TextEditingController identifierController1 = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: emailController1,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: identifierController1,
                decoration: InputDecoration(
                  labelText: "Identifiant",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Annuler"),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue.shade900,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _nominateAssistantAdmin(
                  identifierController1.text,
                  emailController1.text,
                );
                Navigator.of(context).pop();
              },
              child: Text("Nommer"),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue.shade900,
              ),
            ),
          ],
        );
      },
    );
  }

  void _showNominationMarchandDialog(BuildContext context, String title) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController identifierController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: identifierController,
                decoration: InputDecoration(
                  labelText: "Identifiant",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Annuler"),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue.shade900,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _nominateMerchant(
                  identifierController.text,
                  emailController.text,
                );
                Navigator.of(context).pop();
              },
              child: Text("Nommer"),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue.shade900,
              ),
            ),
          ],
        );
      },
    );
  }


  void _showDesactiverCompteDialog(BuildContext context, String title) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController identifierController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: identifierController,
                decoration: InputDecoration(
                  labelText: "Identifiant",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Annuler"),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue.shade900,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // _desactiver(
                //   identifierController.text,
                //   emailController.text,
               // );
                Navigator.of(context).pop();
              },
              child: Text("Désactiver"),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue.shade900,
              ),
            ),
          ],
        );
      },
    );
  }

  void _navigateTo(BuildContext context, String routeName) {
    Navigator.pushNamed(context, routeName);
  }


// Fonction pour se déconnecter

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => PageDeConnexion(onLoginSuccess: () {})),
          (Route<dynamic> route) => false,
    );
  }

  // Fonction pour créer une tuile cliquable
  Widget _buildClickableListTile1(BuildContext context, String text, Function() onTap) {
    return ListTile(
      title: Text(
        text,
        style: TextStyle(fontSize: 18, color: Colors.blue.shade900.withOpacity(0.8)),
      ),
      onTap: onTap,
    );
  }

  // Fonction pour créer une tuile cliquable
  Widget _buildClickableListTile(BuildContext context, String text, Function() onTap) {
    return ListTile(
      title: Text(
        text,
        style: TextStyle(fontSize: 18, color: Colors.blue.shade900.withOpacity(0.8)),
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Profil Admin")),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        backgroundColor: Colors.blue.shade900,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Image.asset('assets/images/logo/newlogo.png', width: 100, height: 100),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Administrateur",
                      style: TextStyle(fontSize: 20, color: Colors.blue.shade900.withOpacity(0.8)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.blue.shade900.withOpacity(0.8),
                  width: double.infinity,
                  height: 5,
                ),
              ),
              SizedBox(height: 10),
              ListView(
                shrinkWrap: true,
                primary: false,
                children: [
                  _buildClickableListTile(context, "Recharger le solde client", () => _showRechargeClientDialog(context, "Recharger le solde client")),
                  _buildClickableListTile(context, "Faire retrait à un  client", () => _showRetraitClientDialog(context, "Faire retrait à un  client")),
                  _buildClickableListTile(context, "Recharger le solde d'un marchand", () => _showRechargeMarchandDialog(context,"Recharger le solde d'un marchand")),
                  _buildClickableListTile(context, "Faire retrait à un marchand", () => _showRetraitMarchandDialog(context,"Faire retrait à un marchand")),
                 _buildClickableListTile(context, "Recharger le solde d'un Assistant", () => _showRechargeAssistantDialog(context,"Recharger le solde d'un Assistant")),
                  _buildClickableListTile(context, "Faire retrait à un Assistant", () =>    _showRetraitAssistantDialog(context,"Faire retrait à un Assistant")),
                  _buildClickableListTile1(context, "Nommer un Assistant", () => _showNominationAssistantDialog(context, "Nommer un Assistant")),
                  _buildClickableListTile(context, "Nommer un Marchand", () => _showNominationMarchandDialog(context, "Nommer un Marchand")),
                  _buildClickableListTile(context, "Désactiver un compte", () =>_showDesactiverCompteDialog(context, "Désactiver un compte")),
                  _buildClickableListTile(context, "Se déconnecter", () => _logout()),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

