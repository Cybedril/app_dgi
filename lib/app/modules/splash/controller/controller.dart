import 'package:flutter/material.dart';
import 'package:impots_benin/app/modules/welcome/view/welcome.dart';

time(BuildContext context){
  Future.delayed(Duration(seconds: 5),(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Welcome(),));
    //print("Bonjour, tout le monde");
  });
}