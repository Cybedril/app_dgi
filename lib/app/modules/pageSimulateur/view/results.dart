import 'package:flutter/material.dart';
import 'package:impots_benin/app/components/button_components.dart';
import 'package:impots_benin/app/components/space.dart';
import 'package:impots_benin/app/components/text_components.dart';
import 'package:impots_benin/app/modules/pageEcheances/controller/controller.dart';
import 'package:impots_benin/app/modules/pageSimulateur/view/finalisation.dart';
import 'package:impots_benin/useful/colors.dart';

class Results extends StatefulWidget {
  const Results({super.key});

  @override
  State<Results> createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(250),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: TextComponents(
            txt: "Simulateur",
            fw: FontWeight.bold,
            family: 'Bold',
            txtSize: 18,
          ),
          flexibleSpace: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 70),
                  ProgressBar(stepActuel: 4, stepActuel2: 3),
                  h(50),
                  Center(
                    child: TextComponents(
                      txt: "Êtes-vous prêt ?",
                      fw: FontWeight.bold,
                      family: 'Bold',
                      txtSize: 16,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 20, left: 20),
        child: Center(
            child: Column(
                children: [
                  Image.asset("assets/images/Tax-amico.png", scale: 7 ,),
                  h(40),
                  InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            transitionDuration: const Duration(milliseconds: 400),
                            pageBuilder: (_, __, ___) => Finalisation(),
                            transitionsBuilder: (_, animation, __, child) {
                              return ScaleTransition(
                                scale: CurvedAnimation(parent: animation, curve: Curves.easeInOut),
                                child: child,
                              );
                            },
                          ),
                        );
                      },

                      child: ButtonComponent(txtButton: 'Calculer', buttonColor: mainColor, textColor: Colors.white))
                ]

            ),
          ),
      ),
    );
  }
}
