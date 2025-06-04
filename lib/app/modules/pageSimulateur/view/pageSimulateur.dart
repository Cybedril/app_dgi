import 'package:flutter/material.dart';
import 'package:impots_benin/app/components/button_components.dart';
import 'package:impots_benin/app/components/space.dart';
import 'package:impots_benin/app/components/text_components.dart';
import 'package:impots_benin/app/modules/pageSimulateur/view/secteur_activite.dart';
import 'package:impots_benin/useful/colors.dart';

class Pagesimulateur extends StatefulWidget {
  const Pagesimulateur({super.key});

  @override
  State<Pagesimulateur> createState() => _PagesimulateurState();
}

class _PagesimulateurState extends State<Pagesimulateur> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundApp,
      body: Padding(
        padding: const EdgeInsets.only(top: 180, right: 20, left: 20),
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextComponents(
                txt: 'Nous vous aidons à trouver',
                txtSize: 20,
                fw: FontWeight.bold,
                family: 'Bold',
                align: TextAlign.center,
              ),
              TextComponents(
                txt: 'une estimation du montant',
                txtSize: 20,
                fw: FontWeight.bold,
                family: 'Bold',
                align: TextAlign.center,
              ),
              TextComponents(
                txt: 'de vos impôts !',
                txtSize: 20,
                fw: FontWeight.bold,
                family: 'Bold',
                align: TextAlign.center,
              ),
              h(20),
              TextComponents(
                txt: "impots.benin vous facilite la tâche",
                txtSize: 15,
                family: 'Regular',
              ),
              h(25),
              ClipRRect(
                borderRadius: BorderRadius.circular(20), // 👈 bord arrondi
                child: Image.asset(
                  "assets/images/team.jpg",
                  fit: BoxFit.cover,
                ),
              ),
              h(35),
              InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SecteurActivite(),));
                  },
                  child: ButtonComponent(txtButton: 'Continuer', buttonColor: mainColor, textColor: Colors.white))
            ],
          ),
        ),
      ),
    );
  }
}
