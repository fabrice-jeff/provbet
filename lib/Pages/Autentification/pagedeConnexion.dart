import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:probet/Pages/Autentification/page_D_Inscription.dart';
import 'package:probet/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../HomePage/HomePageAssistantsuperAdmin/homePageAssistantWrapper.dart';
import '../HomePage/HomePageMarchand/home_marchandWrapper.dart';
import '../HomePage/HomePagesupeAdmin/home_super_adminWrapper.dart';
import 'motDepasseOublier.dart';

class PageDeConnexion extends StatefulWidget {
  final VoidCallback onLoginSuccess;

  const PageDeConnexion({Key? key, required this.onLoginSuccess}) : super(key: key);

  @override
  State<PageDeConnexion> createState() => _PageDeConnexionState();
}

class _PageDeConnexionState extends State<PageDeConnexion> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    final String apiUrl = 'https://provbet.com/api/login';
    final Map<String, dynamic> body = {
      'email': _emailController.text,
      'password': _passwordController.text,
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
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Connexion réussie!')),
        );

        // Enregistrer le token via SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', responseData['token'] ?? '');

        // Appeler l'API pour obtenir les informations de l'utilisateur
        await _getUserInfo();

        widget.onLoginSuccess();
      } else {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Veuillez vous inscrire ou entrer vos données correctes car : ${responseData['message']}',
              style: TextStyle(color: Colors.red),
            ),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur de connexion : $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _getUserInfo() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      if (token == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Token non trouvé.')),
        );
        return;
      }

      final String apiUrl = 'https://provbet.com/api/user/current';
      final http.Response response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> userData = jsonDecode(response.body);
        final List<String> roles = List<String>.from(userData['roles'] ?? []);
        print(roles);

        // Vérifier le rôle de l'utilisateur et naviguer vers la page appropriée
        if (roles.contains('ROLE_SUPER_ADMIN')) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeSuperAdminwrapper()),
          );
        } else if (roles.contains('ROLE_ASSISTANT_ADMIN')) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePageAssistantWrapper()),
          );
        } else if (roles.contains('ROLE_USER_MERCHANT')) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Home_marchandwrapper()),
          );
        } else if (roles.contains('ROLE_USER')) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePageWrapper())//HomePage(onPlayPressed: () {},)),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Rôle non reconnu.')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors de la récupération des informations de l\'utilisateur.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur de connexion : $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: Center(child: Text("Connexion", style: TextStyle(color: Colors.white))),
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
              _buildTextField(_emailController, 'Email'),
              SizedBox(height: 15),
              _buildPasswordField(_passwordController, 'Mot de passe'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isLoading ? null : _login,
                child: _isLoading
                    ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                )
                    : Text(
                  "Se connecter",
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
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Page_D_Inscription(),
                    ),
                  );
                },
                child: RichText(
                  text: TextSpan(
                    text: "Vous êtes nouveau?",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                    children: <TextSpan>[
                      TextSpan(text: ' '),
                      TextSpan(
                        text: 'Inscrivez-vous',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MotDePasseOublier(),
                    ),
                  );
                },
                child: RichText(
                  text: TextSpan(
                    text: "Mot de passe oublié?",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                    children: <TextSpan>[
                      TextSpan(text: ' '),
                      TextSpan(
                        text: 'Réinitialiser',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
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
          floatingLabelStyle: TextStyle(color: Colors.transparent),
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
          floatingLabelStyle: TextStyle(color: Colors.transparent),
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
