import 'package:flutter/material.dart';
import 'package:impots_benin/app/components/button_components.dart';
import 'package:impots_benin/app/components/space.dart';
import 'package:impots_benin/app/components/text_components.dart';
import 'package:impots_benin/app/modules/pageAccueil/view/pageAccueil.dart';
import 'package:impots_benin/useful/colors.dart';

class Changestate2 extends StatefulWidget {
  const Changestate2({super.key});

  @override
  State<Changestate2> createState() => _Changestate2State();
}

class _Changestate2State extends State<Changestate2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 150.0), // Marge gauche/droite et espace au-dessus
        child: Container(
          height: MediaQuery.of(context).size.height / 2,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Centrer le contenu verticalement
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 150),
              h(20),
              TextComponents(
                txt: "Félicitations ! ",
                fw: FontWeight.bold,
                family: "Bold",
                txtSize: 28,
              ),
              h(20),
              TextComponents(
                txt: "Votre mot de passe a été bien changé. ",
                txtSize: 16,
                textAlign: TextAlign.center,
              ),
              h(40),
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Pageaccueil(),));
                },
                child: ButtonComponent(
                  txtButton: "Continuer",
                  buttonColor: mainColor,
                  textColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
