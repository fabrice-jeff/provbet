import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../Models/country.dart';
import 'pagedeConnexion.dart';

class Page_D_Inscription extends StatefulWidget {
  const Page_D_Inscription({Key? key}) : super(key: key);

  @override
  State<Page_D_Inscription> createState() => _Page_D_InscriptionState();
}

class _Page_D_InscriptionState extends State<Page_D_Inscription> {
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmationController = TextEditingController();
  String? selectedCountryCode;
  List<Country> countries = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchCountries();
  }

  @override
  void dispose() {
    _lastNameController.dispose();
    _firstNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmationController.dispose();
    super.dispose();
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

  Future<void> _register() async {
    setState(() {
      _isLoading = true;
    });

    final String apiUrl = 'https://provbet.com/api/create-account';
    final Map<String, dynamic> body = {
      'lastName': _lastNameController.text,
      'firstName': _firstNameController.text,
      'email': _emailController.text,
      'country': selectedCountryCode,
      'password': _passwordController.text,
      'password_confirmation': _passwordConfirmationController.text,
    };

    try {
      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Inscription réussie!')),
        );
        Navigator.of(context).pop();
      } else {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Échec de l\'inscription : ${responseData['message']}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur d\'inscription : $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: Center(child: Text("Inscription")),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.blue.shade900,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 100),
              Image.asset(
                'assets/images/logo/newlogo.png',
                height: 120,
                width: 400,
              ),
              SizedBox(height: 20),
              _buildTextField(_lastNameController, 'Nom'),
              SizedBox(height: 15),
              _buildTextField(_firstNameController, 'Prénom'),
              SizedBox(height: 15),
              _buildTextField(_emailController, 'Email'),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Theme(
                  data: Theme.of(context).copyWith(canvasColor: Colors.white70),
                  child: DropdownButtonFormField<String>(
                    dropdownColor: Colors.white,
                    items: countries.map((country) {
                      return DropdownMenuItem<String>(
                        value: country.code,
                        child: SizedBox(
                          width: 200, // Définissez la largeur désirée ici
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
                      fillColor: Colors.white, // Définit la couleur de fond en blanc
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

              SizedBox(height: 15),
              _buildPasswordField(_passwordController, 'Mot de passe'),
              SizedBox(height: 15),
              _buildPasswordField(_passwordConfirmationController, 'Confirmer mot de passe'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isLoading ? null : _register,
                child: _isLoading
                    ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                )
                    : Text(
                  "S'inscrire",
                  style: TextStyle(color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 8),
                  textStyle: TextStyle(fontSize: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: BorderSide(color: Colors.yellow),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PageDeConnexion(
                            onLoginSuccess: () {
                              print('Connexion réussie !');
                            },
                          ),
                        ),
                      );
                    },
                    child: RichText(
                      text: TextSpan(
                        text: "Vous avez déjà un compte",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                        children: <TextSpan>[
                          TextSpan(text: ' '),
                          TextSpan(
                            text: 'Se connecter',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Container(
                height: 40,
                width: 400,
                decoration: BoxDecoration(
                  color: Colors.blue.shade900,
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.black54, fontSize: 20),
          filled: true,
          fillColor: Colors.white,
          floatingLabelStyle: TextStyle(
              color: Colors.transparent
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(45),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(45),
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField(TextEditingController controller, String labelText) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.black54, fontSize: 20),
          filled: true,
          fillColor: Colors.white,
          floatingLabelStyle: TextStyle(
              color: Colors.transparent
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(45),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(45),
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
        obscureText: true,
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
