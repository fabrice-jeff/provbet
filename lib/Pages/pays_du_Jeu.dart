import 'package:flutter/material.dart';
import 'Boule/selection_Des_boules.dart';

class Pays_DansLeguel_JeuDisponible extends StatefulWidget {
  final VoidCallback onBouleTap;
  const Pays_DansLeguel_JeuDisponible({Key? key, required this.onBouleTap})
      : super(key: key);

  @override
  State<Pays_DansLeguel_JeuDisponible> createState() =>
      _Pays_DansLeguel_JeuDisponibleState();
}

class _Pays_DansLeguel_JeuDisponibleState
    extends State<Pays_DansLeguel_JeuDisponible> {
  int _currentHour = DateTime.now().hour;
  bool _isHour11Clickable = false;
  bool _isHour15Clickable = false;
  bool _isHour18Clickable = false;

  // Méthode pour naviguer vers la sélection des boules
  void _navigateToSelectionDesBoules(int hours) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Selection_Des_Boules(
          onPlayPressed: () {
            // Logique à exécuter lors du clic sur "Jouer"
          },
          onValidation: (String type, Set<int> numbers, double amount) {
            // Logique à exécuter lors de la validation du ticket
          },
          selectedHour: hours,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _updateHourClickableStatus(); // Met à jour les heures où l'utilisateur peut cliquer
  }

  // Méthode pour mettre à jour les heures cliquables
  void _updateHourClickableStatus() {
    setState(() {
      if (_currentHour >= 18 || _currentHour < 11) {
        _isHour11Clickable = true;
        _isHour15Clickable = false;
        _isHour18Clickable = false;
      } else if (_currentHour >= 11 && _currentHour < 15) {
        _isHour11Clickable = false;
        _isHour15Clickable = true;
        _isHour18Clickable = false;
      } else if (_currentHour >= 15 && _currentHour < 18) {
        _isHour11Clickable = false;
        _isHour15Clickable = false;
        _isHour18Clickable = true;
      } else {
        _isHour11Clickable = false;
        _isHour15Clickable = false;
        _isHour18Clickable = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue.shade900,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Center(
              child: Text(
                "Les pays dans lesquels se trouve la Probet :",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        _buildCountryTile(
                            'Benin', 'assets/images/benin.jpg', 11,
                            isHourClickable: _isHour11Clickable),
                        _buildCountryTile('Togo', 'assets/images/togo.jpg', 13,
                            isAvailable: false),
                        _buildCountryTile(
                            'Nigeria', 'assets/images/nigeria.jpg', 15,
                            isAvailable: false),
                        _buildCountryTile('Côte d\'Ivoire',
                            'assets/images/cotedivoire.jpg', 10,
                            isAvailable: false),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        _buildCountryTile(
                            'Benin', 'assets/images/benin.jpg', 15,
                            isHourClickable: _isHour15Clickable),
                        _buildCountryTile('Togo', 'assets/images/togo.jpg', 20,
                            isAvailable: false),
                        _buildCountryTile(
                            'Nigeria', 'assets/images/nigeria.jpg', 19,
                            isAvailable: false),
                        _buildCountryTile('Côte d\'Ivoire',
                            'assets/images/cotedivoire.jpg', 11,
                            isAvailable: false),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        _buildCountryTile(
                            'Benin', 'assets/images/benin.jpg', 18,
                            isHourClickable: _isHour18Clickable),
                        _buildCountryTile('Togo', 'assets/images/togo.jpg', 20,
                            isAvailable: false),
                        _buildCountryTile(
                            'Nigeria', 'assets/images/nigeria.jpg', 19,
                            isAvailable: false),
                        _buildCountryTile('Côte d\'Ivoire',
                            'assets/images/cotedivoire.jpg', 11,
                            isAvailable: false),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget pour construire la tuile de pays
  Widget _buildCountryTile(String countryName, String imagePath, int hours,
      {bool isAvailable = true, bool isHourClickable = false}) {
    bool isHourRed = false;
    Color textColor = Colors.white;
    double opacity = 1.0;

    if (countryName == 'Benin' && isHourClickable) {
      isHourRed = true;
    }

    if (!isAvailable) {
      textColor =
          Colors.white.withOpacity(0.5); // Texte en blanc avec opacité réduite
      opacity = 0.5; // Opacité réduite pour l'image
    }

    return Expanded(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              if (isAvailable && isHourRed) {
                _navigateToSelectionDesBoules(hours);
              }
            }, // Appel de la méthode de navigation
            child: Text(
              '$countryName - $hours H',
              style: TextStyle(
                color: isHourRed ? Colors.red : textColor.withOpacity(0.7),
                fontSize: 18,
              ),
            ),
          ),
          SizedBox(height: 4),
          Expanded(
            child: GestureDetector(
              onTap: isAvailable && isHourRed
                  ? () => _navigateToSelectionDesBoules(hours)
                  : null, // Navigation uniquement si disponible et dans l'intervalle correct
              child: Opacity(
                opacity: opacity,
                child: Container(
                  height: 50,
                  width: 150,
                  margin: EdgeInsets.only(top: 4, left: 10, right: 10),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(imagePath),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
