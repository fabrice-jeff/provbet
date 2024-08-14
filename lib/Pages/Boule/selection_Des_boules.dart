import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:probet/Models/ticket_model.dart';
import 'package:probet/Pages/Profil/Parieur/profilUtilisateur.dart';
import 'package:probet/Pages/notification.dart';
import 'package:probet/Pages/pagedeValidationTicket.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Models/typeBet.dart';
import '../../services/constantstypePari.dart';


class Selection_Des_Boules extends StatefulWidget {
  final VoidCallback onPlayPressed;
  final Function(String, Set<int>, double) onValidation;
  final int selectedHour;
  final String? numeroTicket;

  const Selection_Des_Boules({
    Key? key,
    required this.onPlayPressed,
    required this.onValidation,
    required this.selectedHour,
    this.numeroTicket,

  }) : super(key: key);
  @override
  State<Selection_Des_Boules> createState() => _Selection_Des_BoulesState();
}

class _Selection_Des_BoulesState extends State<Selection_Des_Boules> {
  int _currentIndex = 1;
  List<int> _selectedNumbers = [];
  List<int> _validatedNumbers = [];
  bool _isResetButtonClicked = false;
  bool _isValidateButtonClicked = false;
  TextEditingController _betAmountController = TextEditingController();
  List<Typebet> _betTypes = [];
  Typebet? _selectedBetType;

  @override
  void initState() {
    super.initState();
    _fetchBetTypes();
  }

  Future<void> _fetchBetTypes() async {
    final url = Uri.parse('https://provbet.com/api/type_bet/');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
     print(response.statusCode);
      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        setState(() {
          _betTypes = responseData.map((json) => Typebet.fromJson(json)).toList();
          _selectedBetType = _betTypes.isNotEmpty ? _betTypes[0] : null;
        });
      } else if (response.statusCode == 401) {
        _handleUnauthorized();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors de la récupération des types de paris')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Une erreur s\'est produite: $e')),
      );
    }
  }

  Future<void> _handleUnauthorized() async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Session expirée. Veuillez vous reconnecter.')),
    );

  }

  void _selectBetType(Typebet? newValue) {
    setState(() {
      _selectedBetType = newValue;
      _selectedNumbers.clear();
    });
  }

  void _toggleNumberSelection(int number) {
    if (_validatedNumbers.contains(number)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ce numéro a déjà été validé.')),
      );
      return;
    }
    setState(() {
      int maxSelections;
      switch (_selectedBetType?.reference) {
        case TYPE_BET_NAP1_POTO:
        case TYPE_BET_NAP1_BLOQUE:
          maxSelections = 1;
          break;
        case TYPE_BET_NAP2:
          maxSelections = 2;
          break;
        case TYPE_BET_NAP3:
          maxSelections = 3;
          break;
        case TYPE_BET_NAP4:
          maxSelections = 4;
          break;
        case TYPE_BET_NAP5:
        case TYPE_BET_TCHIGAN:
          maxSelections = 5;
          break;
        case TYPE_BET_PERM2:
        case TYPE_BET_PERM3:
          maxSelections = 20;
          break;
        default:
          maxSelections = 5;
          break;
      }

      if (_selectedNumbers.length < maxSelections ||
          _selectedNumbers.contains(number)) {
        if (_selectedNumbers.contains(number)) {
          _selectedNumbers.remove(number);
        } else {
          _selectedNumbers.add(number);
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                'Vous ne pouvez sélectionner que $maxSelections boules pour le pari ${_selectedBetType?.name}.',
                style: TextStyle(color: Colors.red),
              )),
        );
      }
    });
  }
  void _resetSelection() {
    setState(() {
      _selectedNumbers.clear();
      _isResetButtonClicked = !_isResetButtonClicked;
      _isValidateButtonClicked = false;
    });
  }

  Future<void> _validateSelection() async {
    double betAmount = double.tryParse(_betAmountController.text) ?? 0.0;

    if (_selectedBetType?.reference == TYPE_BET_TCHIGAN && betAmount < 310) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
              'Le montant du pari pour Tchigan doit être supérieur ou égal à 310 F.',
              style: TextStyle(color: Colors.red),
            )),
      );
      return;
    }

    if (_selectedBetType?.reference == TYPE_BET_TCHIGAN && _selectedNumbers.length != 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
              'Vous devez sélectionner exactement 5 boules pour le pari ${_selectedBetType?.name}.',
              style: TextStyle(color: Colors.red),
            )),
      );
      return;
    }

    if ((_selectedBetType?.reference == TYPE_BET_NAP1_POTO ||
        _selectedBetType?.reference == TYPE_BET_NAP1_BLOQUE) &&
        betAmount < 100) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
              'Le montant du pari pour ${_selectedBetType?.name} doit être supérieur ou égal à 100 F.',
              style: TextStyle(color: Colors.red),
            )),
      );
      return;
    }

    if ((_selectedBetType?.reference == TYPE_BET_NAP2 ||
        _selectedBetType?.reference == TYPE_BET_NAP3 ||
        _selectedBetType?.reference == TYPE_BET_NAP4 ||
        _selectedBetType?.reference == TYPE_BET_NAP5) &&
        betAmount < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
              'Le montant du pari pour ${_selectedBetType?.name} doit être supérieur ou égal à 10F.',
              style: TextStyle(color: Colors.red),
            )),
      );
      return;
    }

    if ((_selectedBetType?.reference ==  TYPE_BET_NAP2 && _selectedNumbers.length != 2) ||
        (_selectedBetType?.reference ==  TYPE_BET_NAP3 && _selectedNumbers.length != 3) ||
        (_selectedBetType?.reference ==  TYPE_BET_NAP4 && _selectedNumbers.length != 4) ||
        (_selectedBetType?.reference ==  TYPE_BET_NAP5 && _selectedNumbers.length != 5)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
              'Vous devez sélectionner exactement ${_selectedBetType?.reference.substring(3)} boules pour le pari ${_selectedBetType?.name}.',
              style: TextStyle(color: Colors.red),
            )),
      );
      return;
    }

    double totalBetCost = 0.0;

    if (_selectedBetType?.reference == TYPE_BET_PERM2) {
      int numberOfCombinations =
      _calculatePermutations(_selectedNumbers.length, 2);
      totalBetCost = numberOfCombinations * 10.0 / 2;

      if (betAmount < totalBetCost) {
        int montant = totalBetCost.toInt();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                'Le montant du pari doit être supérieur ou égal à $montant fCFA pour Perm 2.',
                style: TextStyle(color: Colors.red),
              )),
        );
        return;
      }
    } else if (_selectedBetType?.reference == TYPE_BET_PERM3) {
      int numberOfCombinations =
      _calculatePermutations(_selectedNumbers.length, 3);
      totalBetCost = numberOfCombinations * 10.0 / 6.66;

      if (betAmount < totalBetCost) {
        int montant = totalBetCost.toInt();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                'Le montant du pari doit être supérieur ou égal à $montant fCFA pour Perm 3.',
                style: TextStyle(color: Colors.red),
              )),
        );
        return;
      }
    }

    String numTicket = (widget.numeroTicket != null)
        ? widget.numeroTicket!
        : _generateTicketNumber(widget.selectedHour).toString(); // Assurez-vous que c'est une chaîne


    final response = await _saveBet(
      betType: _selectedBetType?.reference ?? '',
      selectedNumbers: _selectedNumbers.toList(),
      betAmount: betAmount,
      numTicket: numTicket,
    );
    if (response['success']) {
      setState(() {
        _validatedNumbers.addAll(_selectedNumbers);
        _selectedNumbers.clear();
        _isValidateButtonClicked = true;
        _isResetButtonClicked = false;
      });

      // Recuperation des données enregistrée dans la base donée pour l'envoyer sur la page ValidationDesTicket()
      final betData = await _fetchBetData(numTicket);
      //print('le type de variable:${betData['amount'].runtimeType}');
      betData['draw']['startTime'] = "15";
      betData['draw']['bets'] = betData['bets'];
      double amount = 0;
      for (var bet in betData['draw']['bets']) {
        amount += bet['amount'];
      }
      betData['draw']['amount'] = amount.toString();
     // print(betData['draw']['amount'].runtimeType);
      Ticket ticket = Ticket.fromJson(betData['draw']);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return ValidationDesTicket(ticket: ticket);
          },
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
            Text('Sélection validée: ${_validatedNumbers.join(', ')}')),
      );
    } else if (response['status'] == 401) {
      _handleUnauthorized();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
              'Erreur lors de l\'enregistrement du pari: ${response['message']}',
              style: TextStyle(color: Colors.red),
            )),
      );
    }
  }



  Future<Map<String, dynamic>> _saveBet({
    required String betType,
    required List<int> selectedNumbers,
    required double betAmount,
    required String numTicket,
  }) async {
    final url = Uri.parse('https://provbet.com/api/user/play');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer $token",
        },
        body: jsonEncode({
          'type_bet': betType,
          'balls': selectedNumbers.toString(),
          'amount': betAmount.toString(),
          'number_draw': numTicket,
        }),
      );
      print(numTicket);
      print(selectedNumbers);
      print(response.statusCode);
      if (response.statusCode == 200) {
        return {
          'success': true,
          'data': jsonDecode(response.body),
        };
      } else if (response.statusCode == 401) {
        return {
          'success': false,
          'status': 401,
          'message': 'Unauthorized',
        };
      } else {
        print(response.body);
        return {
          'success': false,
          'message': 'Erreur serveur. Veuillez réessayer plus tard.',
        };
      }
    } catch (e) {
      print(e);
      return {
        'success': false,
        'message': 'Une erreur s\'est produite: $e',
      };
    }
  }

  Future<Map<String, dynamic>> _fetchBetData(String numTicket) async {
    final url = Uri.parse('https://provbet.com/api/user/draw/$numTicket');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token');

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer $token",
        },
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        _handleUnauthorized();
        return {};
      } else {
        throw Exception('Erreur serveur. Veuillez réessayer plus tard.');
      }
    } catch (e) {
      throw Exception('Une erreur s\'est produite: $e');
    }
  }

  int _calculatePermutations(int n, int k) {
    if (k > n) return 0;
    return _factorial(n) ~/ _factorial(n - k);
  }

  int _factorial(int n) {
    if (n <= 1) return 1;
    return n * _factorial(n - 1);
  }

  String _generateTicketNumber(int hour) {
    String prefix;
    if (hour >= 18 || hour < 11) {
      prefix = 'Fi'; // Fifa
    } else if (hour >= 11 && hour < 15) {
      prefix = 'Re'; // Repo
    } else {
      prefix = 'Vi'; // Vivi
    }
    int radical = DateTime.now().millisecondsSinceEpoch;
    return '$prefix$radical';
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
            icon: Icon(Icons.notifications, size: 40,color: Colors.white,),
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
                MaterialPageRoute(builder: (context) => ProfilUtilisateur()),
              );
            },
          ),
          SizedBox(width: 20),
        ],
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.blue.shade900,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/boules.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.30),
                  BlendMode.dstATop,
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Container(
                height: 180,
                width: 350,
                decoration: BoxDecoration(
                  color: Colors.blue.shade900,
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(
                                "Type de pari",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            SizedBox(width:10),
                            Container(
                              height: 60,
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              child:Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 3),
                                child: Theme(
                                  data: Theme.of(context).copyWith(canvasColor: Colors.white70),
                                  child: DropdownButtonFormField<Typebet>(
                                    dropdownColor: Colors.blue.shade900,
                                    iconEnabledColor: Colors.white,
                                    items: _betTypes.map( (Typebet betType) {
                                      return DropdownMenuItem<Typebet>(
                                        value: betType,
                                        child: SizedBox(
                                          width: 120, // Définissez la largeur désirée ici
                                          child: Text(
                                            betType.name,
                                            style: TextStyle(color: Colors.white,fontSize: 15),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    value: _selectedBetType,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.blue.shade900, // Définit la couleur de fond en blanc
                                      icon: Padding(
                                        padding: const EdgeInsets.only(left: 8.0),
                                      ),
                                      labelStyle: TextStyle(color: Colors.white),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none
                                        //borderRadius: BorderRadius.circular(25),
                                      ),
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedBetType = value!;
                                      });
                                    },
                                  ),
                                ),
                              ),

                            ),
                          ],
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 70,right: 70,top: 20),
                      //   child: TextFormField(
                      //     //controller:, //_betAmountController,
                      //     keyboardType: TextInputType.number,
                      //     inputFormatters: [
                      //       FilteringTextInputFormatter.digitsOnly
                      //     ],
                      //     style: TextStyle(color: Colors.white),
                      //     decoration: InputDecoration(
                      //       labelText: 'Nombre de prise ',
                      //       labelStyle: TextStyle(color: Colors.white),
                      //       enabledBorder: OutlineInputBorder(
                      //         borderSide: BorderSide(color: Colors.white),
                      //         borderRadius: BorderRadius.circular(15.0),
                      //       ),
                      //       focusedBorder: OutlineInputBorder(
                      //         borderSide: BorderSide(color: Colors.white),
                      //         borderRadius: BorderRadius.circular(15.0),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          "Nombre de prise",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                     ]
                    )
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 120,right: 120),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: TextFormField(
                            //controller:, //_betAmountController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              //labelText: 'Nombre de prise ',
                              labelStyle: TextStyle(color: Colors.white),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                          ),
                      ),
                    ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 10,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                  itemCount: 90,
                  itemBuilder: (context, index) {
                    final number = index + 1;
                    final isSelected = _selectedNumbers.contains(number);
                    final isValidated = _validatedNumbers.contains(number);

                    return GestureDetector(
                      onTap: () => _toggleNumberSelection(number),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isValidated
                              ? Colors.grey
                              : isSelected
                              ? Colors.blue.shade900
                              : Colors.white70,
                        ),
                        child: Center(
                          child: Text(
                            number.toString(),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: 350,
                height: 200,
                padding:
                EdgeInsets.only(top: 10.0, bottom: 10, left: 22, right: 20),
                decoration: BoxDecoration(
                  color: Colors.blue.shade900,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 10),
                      if (_selectedNumbers.isNotEmpty)
                        Wrap(
                          spacing: 10.0,
                          children: _selectedNumbers.map((number) {
                            return Chip(
                              label: Text(
                                number.toString(),
                                style: TextStyle(color: Colors.blue.shade900),
                              ),
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.blue.shade900),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            );
                          }).toList(),
                        ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 40.0, right: 40, top: 60),
                        child: TextFormField(
                          controller: _betAmountController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'Montant du pari (FCFA)',
                            labelStyle: TextStyle(color: Colors.white),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: _resetSelection,
                            style: ElevatedButton.styleFrom(
                              foregroundColor: _isResetButtonClicked
                                  ? Colors.white
                                  : Colors.blue.shade900,
                              disabledForegroundColor: _isResetButtonClicked
                                  ? Colors.blue.shade900
                                  : Colors.white,
                              side: BorderSide(color: Colors.red),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                            ),
                            child: Text(
                              'Réinitialiser',
                              style: TextStyle(
                                  color: _isResetButtonClicked
                                      ? Colors.blue.shade900
                                      : Colors.white),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: _validateSelection,
                            style: ElevatedButton.styleFrom(
                              foregroundColor: _isValidateButtonClicked
                                  ? Colors.white
                                  : Colors.white,
                              disabledForegroundColor: _isValidateButtonClicked
                                  ? Colors.blue.shade900
                                  : Colors.white,
                              side: BorderSide(color: Colors.red),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                            ),
                            child: Text(
                              'Valider',
                              style: TextStyle(
                                  color: _isValidateButtonClicked
                                      ? Colors.blue.shade900
                                      : Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ],
      ),
    );
  }
}
