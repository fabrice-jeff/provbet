import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Models/country.dart';
import '../../../Models/user.dart';
import '../../../services/api_service.dart';
import '../../Autentification/pagedeConnexion.dart';
import 'package:http/http.dart' as http;

class ProfilAssistantAmin extends StatefulWidget {
  const ProfilAssistantAmin({Key? key}) : super(key: key);

  @override
  State<ProfilAssistantAmin> createState() => _ProfilAssistantAminState();
}

class _ProfilAssistantAminState extends State<ProfilAssistantAmin> {
  double userBalance1 = 0.0;
  double userBalance2 = 0.0;
  final String profileImageUrl = 'https://avatars0.githubusercontent.com/u/8264639?s=460&v=4';
  // Constants pour les types de transaction
  static const TYPE_TRANSACTION_DEPOSIT = 'TYPE_TRANSACTION_DEPOSIT';
  static const TYPE_TRANSACTION_WITHDRAW = 'TYPE_TRANSACTION_WITHDRAW';

  late Future<User> currentUser;
  String? selectedCountryCode;
  List<Country> countries = [];

  //fontion pour rcuperer la liste des pays
  Future<void> _fetchCountries() async {
    const String apiUrl = 'https://provbet.com/api/country';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        setState(() {
          countries = responseData.map((json) => Country.fromJson(json)).toList();
          selectedCountryCode = countries.isNotEmpty ? countries[0].code : null;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors de la récupération des pays.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur: $e')),
      );
    }
  }


  @override
  void initState() {
    super.initState();
    _fetchUserBalances();
    _fetchCountries();
    currentUser = ApiService().fetchCurrentUser();
  }

  void _fetchUserBalances() async {
    try {
      final balances = await ApiService().fetchUserBalance();
      setState(() {
        // Utilisation de toString() pour gérer les valeurs entières
        userBalance1 = double.parse(balances['main_wallet'].toString());
        //userBalance2 = double.parse(balances['reattach_wallet'].toString());

        print('compte: $userBalance1');
        print('compte2: $userBalance2');
      });
    } catch (e) {
      print('Failed to fetch user balances: $e');
    }
  }


  void _showEditProfileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FutureBuilder<User>(
          future: currentUser,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}', style: TextStyle(fontSize: 20)));
            } else if (snapshot.hasData) {
              final user = snapshot.data!;
              return AlertDialog(
                title: Text("Modifier le profil"),
                content: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text("ID: ${user.identifier}"),
                      TextField(
                        decoration: InputDecoration(
                          labelText: "Nom et prénom",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Theme(
                          data: Theme.of(context).copyWith(canvasColor: Colors.white70),
                          child: DropdownButtonFormField<String>(
                            dropdownColor: Colors.white70,
                            items: countries.map((country) {
                              return DropdownMenuItem<String>(
                                value: country.code,
                                child: SizedBox(
                                  width: 80, // Définissez la largeur désirée ici
                                  child: Text(
                                    country.name,
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                ),
                              );
                            }).toList(),
                            value: selectedCountryCode,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white70, // Définit la couleur de fond en blanc
                              labelStyle: TextStyle(color: Colors.white),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                selectedCountryCode = value!;
                              });
                            },
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Logique de modification de la photo de profil
                        },
                        child: Text("Modifier la photo de profil"),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.blue.shade900,
                          disabledForegroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Annuler"),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.blue.shade900,
                      disabledForegroundColor: Colors.white,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Logique de mise à jour du profil
                      Navigator.of(context).pop();
                    },
                    child: Text("Enregistrer"),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.blue.shade900,
                      disabledForegroundColor: Colors.white,
                    ),
                  ),
                ],
              );
            } else {
              return Center(child: Text('No data'));
            }
          },
        );
      },
    );
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
                // _nominateMerchant(
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

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => PageDeConnexion(onLoginSuccess: () {})),
          (Route<dynamic> route) => false,
    );
  }

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
        title: Center(
            child: Text(
              "Profile Assistant",style: TextStyle(color: Colors.white,fontSize: 25),
            )
        ),
        backgroundColor: Colors.blue.shade900,
        iconTheme: IconThemeData(color: Colors.white),
        //Theme.of(context).textTheme.apply(bodyColor: Colors.white)
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              FutureBuilder<User>(
                future: currentUser,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}',style: TextStyle(fontSize: 20),));
                  } else if (snapshot.hasData) {
                    final user = snapshot.data!;
                    return Row(
                      children: [
                        CircularProfileAvatar(
                          profileImageUrl,
                          radius: 50,
                          backgroundColor: Colors.transparent,
                          borderWidth: 10,
                          initialsText: Text(
                            "",
                            style: TextStyle(fontSize: 40, color: Colors.blueGrey),
                          ),
                          borderColor: Colors.green.withOpacity(0.2),
                          elevation: 5.0,
                          foregroundColor: Colors.blue.shade900.withOpacity(0.3),
                          cacheImage: true,
                          imageFit: BoxFit.cover,
                          showInitialTextAbovePicture: true,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "${user.lastName} ${user.firstName}",
                            style: TextStyle(fontSize: 15, color: Colors.blue.shade900.withOpacity(0.8)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: GestureDetector(
                            onTap: () {
                              _showEditProfileDialog(context);
                            },
                            child: Icon(Icons.mode_edit_outline_outlined),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Center(child: Text('No data'));
                  }
                },
              ),
              Center(child: Text("Solde", style: TextStyle(fontSize: 20, color: Colors.blue.shade900.withOpacity(0.8)),)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 200,
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
                      color: Colors.white70.withOpacity(0.8),
                      border: Border.all(color: Colors.blue.shade900.withOpacity(0.5))
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Center(child: Text("Solde: $userBalance1 FCFA")),
                      //Center(child: Text("Compte Bonus : $userBalance2 FCFA")),
                    ],
                  ),
                ),
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
                  ListView(
                    shrinkWrap: true,
                    primary: false,
                    children: [
                      _buildClickableListTile(context, "Recharger le solde client", () => _showRechargeClientDialog(context, "Recharger le solde client")),
                      _buildClickableListTile(context, "Faire retrait à un  client", () => _showRetraitClientDialog(context, "Faire retrait à un  client")),
                      _buildClickableListTile(context, "Recharger le solde d'un marchand", () => _showRechargeMarchandDialog(context,"Recharger le solde d'un marchand")),
                      _buildClickableListTile(context, "Faire retrait à un marchand", () => _showRetraitMarchandDialog(context,"Faire retrait à un marchand")),
                      //_buildClickableListTile(context, "Recharger le solde d'un Assistant", () => _showRechargeAssistantDialog(context,"Recharger le solde d'un Assistant")),
                      //_buildClickableListTile(context, "Faire retrait à un Assistant", () =>    _showRetraitAssistantDialog(context,"Faire retrait à un Assistant")),
                     // _buildClickableListTile1(context, "Nommer un Assistant", () => _showNominationAssistantDialog(context, "Nommer un Assistant")),
                      //_buildClickableListTile(context, "Nommer un Marchand", () => _showNominationMarchandDialog(context, "Nommer un Marchand")),
                      _buildClickableListTile(context, "Désactiver un compte", () =>_showDesactiverCompteDialog(context, "Désactiver un compte")),
                      _buildClickableListTile(context, "Se déconnecter", () => _logout()),

                    ],
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


