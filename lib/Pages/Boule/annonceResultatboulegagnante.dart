
import 'package:flutter/material.dart';
import 'package:probet/Models/country.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Annonceresultatboulegagnante extends StatefulWidget {
  const Annonceresultatboulegagnante({Key? key}) : super(key: key);

  @override
  State<Annonceresultatboulegagnante> createState() => _AnnonceresultatboulegagnanteState();
}

class _AnnonceresultatboulegagnanteState extends State<Annonceresultatboulegagnante> {
  final List<int> _selectedNumbers = [];
  final List<int> _validatedNumbers = [];
  final TextEditingController _betAmountController = TextEditingController();
  bool _isResetButtonClicked = false;
  bool _isValidateButtonClicked = false;
  String? selectedCountryCode;
  List<Country> countries = [];

  @override
  void initState() {
    super.initState();
    _fetchCountries();
  }


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
  void _toggleNumberSelection(int number) {
    setState(() {
      if (_selectedNumbers.contains(number)) {
        _selectedNumbers.remove(number);
      } else if (_selectedNumbers.length < 5) {
        _selectedNumbers.add(number);
      }
    });
  }

  void _resetSelection() {
    setState(() {
      _selectedNumbers.clear();
      _isResetButtonClicked = true;
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          _isResetButtonClicked = false;
        });
      });
    });
  }

  void _validateSelection() {
    setState(() {
      if (_selectedNumbers.length == 5) {
        _validatedNumbers.addAll(_selectedNumbers);
        _selectedNumbers.clear();
        _isValidateButtonClicked = true;
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            _isValidateButtonClicked = false;
          });
        });
        _sendWinners();  // Send winners when validated
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Vous devez sélectionner exactement 5 numéros.")),
        );
      }
    });
  }

  Future<void> _sendWinners() async {
    final url = Uri.parse('https://provbet.com/api/game/user/pull_winner_balls');

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final body = jsonEncode({
      'balls': _validatedNumbers.toString(),
      'country' : selectedCountryCode
    });

    try {
      final response = await http.post(url, headers: headers, body: body);
       print(response.statusCode);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Les numéros gagnants ont été envoyés.")),
        );
        _validatedNumbers.clear();  // Clear the validated numbers after successful submission
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erreur lors de l'envoi des numéros gagnants.")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erreur réseau: impossible d'envoyer les numéros gagnants.")),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            children: [
              SizedBox(height: 10),
              Container(
                height: 100,
                width: 350,
                decoration: BoxDecoration(
                  color: Colors.blue.shade900,
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child:  Column(
                  mainAxisAlignment:  MainAxisAlignment.center,
                  children: [
                    Text('Choisissez un pays' ,style:  TextStyle(color:  Colors.white),),
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
                            print(selectedCountryCode);
                          },
                        ),
                      ),
                    ),
                  ],
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
                height: 160,
                padding: EdgeInsets.only(top: 10.0, bottom: 10, left: 22, right: 20),
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
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: _resetSelection,
                            style: ElevatedButton.styleFrom(
                              foregroundColor: _isResetButtonClicked ? Colors.white : Colors.blue.shade900,
                              disabledForegroundColor: _isResetButtonClicked ? Colors.blue.shade900 : Colors.white,
                              side: BorderSide(color: Colors.red),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                            ),
                            child: Text(
                              'Réinitialiser',
                              style: TextStyle(color: _isResetButtonClicked ? Colors.blue.shade900 : Colors.white),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: _validateSelection,
                            style: ElevatedButton.styleFrom(
                              foregroundColor: _isValidateButtonClicked ? Colors.white : Colors.white,
                              disabledForegroundColor: _isValidateButtonClicked ? Colors.blue.shade900 : Colors.white,
                              side: BorderSide(color: Colors.red),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                            ),
                            child: Text(
                              'Envoyer',
                              style: TextStyle(color: _isValidateButtonClicked ? Colors.blue.shade900 : Colors.white),
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

