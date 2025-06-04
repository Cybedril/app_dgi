import 'package:flutter/material.dart';
import 'package:impots_benin/app/components/button_components.dart';
import 'package:impots_benin/app/components/text_components.dart';
import 'package:impots_benin/useful/colors.dart';

class Flitre extends StatefulWidget {
  const Flitre({super.key});

  @override
  State<Flitre> createState() => _FlitreState();
}

class _FlitreState extends State<Flitre> {
  final List<String> categories = [
    "Tout",
    "Particulier",
    "Entreprise",
    "Commerçant",
    "Autre",
  ];

  int selectedCategoryIndex = 0;

  final Color blue = mainColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: TextComponents(
          txt: "Filtre",
          fw: FontWeight.bold,
          family: "Bold",
          txtSize: 20,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Align(
              alignment: Alignment.centerLeft,  // Aligne à gauche
              child: TextComponents(
                txt: "Catégories",
                fw: FontWeight.bold,
                family: "Bold",
                txtSize: 17,
              ),
            ),
          ),
          SizedBox(height: 30),  // Réduit l'espace entre "Qui êtes-vous ?" et les catégories
          Positioned(
            bottom: 25,
            left: 0,
            right: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: categories.map((category) {
                    int index = categories.indexOf(category);
                    final bool isSelected = selectedCategoryIndex == index;

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedCategoryIndex = index;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          height: 45,
                          decoration: BoxDecoration(
                            color: isSelected ? mainColor : Colors.grey[100],
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: isSelected
                                ? [
                              BoxShadow(
                                color: mainColor.withOpacity(0.2),
                                blurRadius: 5,
                                offset: const Offset(0, 5),
                              )
                            ]
                                : [],
                          ),
                          child: Center(
                            child: TextComponents(
                              txt: category,
                              color: isSelected ? Colors.white : Colors.black87,
                              family: isSelected ? 'Bold' : 'Regular',
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          SizedBox(height: 40),  // Espacement entre les catégories et le bouton
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),  // Padding à gauche et à droite
            child: ButtonComponent(
              txtButton: "Filtrer maintenant",
              buttonColor: mainColor,
              textColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
