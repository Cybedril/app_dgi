import 'package:flutter/material.dart';
import 'package:impots_benin/app/components/button_components.dart';
import 'package:impots_benin/app/components/space.dart';
import 'package:impots_benin/app/components/text_components.dart';
import 'package:impots_benin/app/modules/changermdp/view/changermdp.dart';
import 'package:impots_benin/useful/colors.dart';

class Otp extends StatefulWidget {
  const Otp({super.key});

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            TextComponents(txt: "Vérification Code",txtSize: 25,family: "Bold",fw: FontWeight.bold,),
            h(15),
            TextComponents(txt: "S'il vous plaît entrez les 4 chiffres envoyés à +2290167961346",txtSize: 16,textAlign: TextAlign.center,),
            h(30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) {
                return Container(
                  height: 60,width: 60,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        counterText: ''
                    ),
                    maxLength: 1,
                    onChanged: (value) {
                      if(value.length==1 && index<5){
                        FocusScope.of(context).nextFocus();
                      }
                      else if(value.isEmpty && index >0){
                        FocusScope.of(context).previousFocus();
                      }
                    },
                  ),
                );
              },),
            ),
            h(20),
            TextComponents(txt: "Le code expire dans  : 02:30",txtSize: 17,),
            h(20),
            InkWell(
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ChangerMotDePasse(),));
              },
              child: Container(
                  margin: EdgeInsets.only(left: 20,right: 20),
                  child: ButtonComponent
                    (txtButton: "Vérifier", buttonColor: mainColor, textColor: Colors.white,)),
            ),
            h(20),
            TextComponents(txt: "Vous n'avez pas reçu de code?  Renvoyer", txtSize: 15,)

          ],
        ),
      ),
    );
  }
}

