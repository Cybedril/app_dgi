import 'package:flutter/material.dart';
import 'package:impots_benin/app/components/button_components.dart';
import 'package:impots_benin/app/components/space.dart';
import 'package:impots_benin/app/components/text_components.dart';
import 'package:impots_benin/app/modules/otp/view/otp.dart';
import 'package:impots_benin/useful/colors.dart';

class motDePasseOublie extends StatefulWidget {
  const motDePasseOublie({super.key});

  @override
  State<motDePasseOublie> createState() => _motDePasseOublieState();
}

class _motDePasseOublieState extends State<motDePasseOublie> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(

      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0),  // Marge gauche et droite
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,  // Changer la disposition verticale
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 5),  // Réduit l'espace en haut en ajustant la hauteur du SizedBox

              TextComponents(
                txt: "Vous avez oublié votre ",
                fw: FontWeight.bold,
                txtSize: 22,
                family: "Bold",
              ),
              TextComponents(
                txt: "Mot De Passe ?",
                fw: FontWeight.bold,
                txtSize: 22,
                family: "Bold",
              ),
              h(20),
              TextComponents(
                txt: "Ne vous inquiétez pas, cela arrive. Veuillez saisir le numéro de téléphone associé à votre compte.",
                textAlign: TextAlign.center,
                txtSize: 15,
              ),
              h(30),
              Image.asset("assets/images/password.png", scale: 7),
              h(30),
              // Numéro de téléphone
              TextFormField(
                keyboardType: TextInputType.number,
                maxLength: 10,
                decoration: InputDecoration(
                  labelText: "Numéro de téléphone",
                  counterText: "",
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  labelStyle: TextStyle(color: Colors.grey),
                  prefix: Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Text("+229", style: TextStyle(fontSize: 16, color: Colors.black)),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent, width: 2),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              h(40),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Otp(),));
                },
                child: ButtonComponent(
                  txtButton: "Envoyer",
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
