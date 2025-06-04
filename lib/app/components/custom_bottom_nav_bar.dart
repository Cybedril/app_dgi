import 'package:flutter/material.dart';
import 'package:impots_benin/useful/colors.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabChange;

  const CustomBottomNavBar({
    required this.selectedIndex,
    required this.onTabChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5), // Ajout du padding haut et bas
      decoration: BoxDecoration(
        color: Colors.white, // Fond de la navbar blanc
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30), // Coins arrondis
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent, // Transparent pour appliquer les coins arrondis
        selectedItemColor: mainColor, // Couleur de l'élément sélectionné
        unselectedItemColor: Colors.grey[600], // Couleur des éléments non sélectionnés
        currentIndex: selectedIndex,
        onTap: onTabChange,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: _buildNavItem(Icons.home, 0),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: _buildNavItem(Icons.calendar_today, 1),
            label: 'Échéances',
          ),
          BottomNavigationBarItem(
            icon: _buildNavItem(Icons.calculate, 2),
            label: 'Simulateur',
          ),
          BottomNavigationBarItem(
            icon: _buildNavItem(Icons.insert_drive_file, 3),
            label: 'Documents',
          ),
          BottomNavigationBarItem(
            icon: _buildNavItem(Icons.settings, 4),
            label: 'Paramètres',
          ),
        ],
        showUnselectedLabels: true,
        selectedFontSize: 12,
        unselectedFontSize: 10,
        selectedLabelStyle: TextStyle(
          fontWeight: FontWeight.bold, // Texte en gras lorsqu'un item est sélectionné
        ),
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.normal, // Texte normal pour les éléments non sélectionnés
        ),
        elevation: 0, // Pas d'ombre pour l'élément de la nav
      ),
    );
  }

  // Méthode pour créer un item de navigation avec une animation d'agrandissement
  Widget _buildNavItem(IconData icon, int index) {
    double size = selectedIndex == index ? 35 : 25; // Agrandir l'icône lorsqu'elle est sélectionnée
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: Icon(
        icon,
        size: size,
        color: selectedIndex == index ? mainColor : Colors.grey[650], // Change la couleur de l'icône
      ),
    );
  }
}
