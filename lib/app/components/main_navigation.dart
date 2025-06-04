import 'package:flutter/material.dart';
import 'package:impots_benin/app/modules/pageAccueil/view/pageAccueil.dart';
import 'package:impots_benin/app/modules/pageDocument/view/pageDocument.dart';
import 'package:impots_benin/app/modules/pageEcheances/view/pageEcheances.dart';
import 'package:impots_benin/app/modules/pageParametres/view/pageParametres.dart';
import 'package:impots_benin/app/modules/pageSimulateur/view/pageSimulateur.dart';
import 'package:impots_benin/app/components/custom_bottom_nav_bar.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({Key? key}) : super(key: key);

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    PageaccueilContent(),
    Pageecheances(),
    Pagesimulateur(),
    Pagedocument(),
    Pageparametres(),
  ];

  void _onTabChange(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onTabChange: _onTabChange,
      ),
    );
  }
}
