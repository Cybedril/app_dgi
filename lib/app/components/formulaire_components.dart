import 'package:flutter/material.dart';

class FormulaireComponents extends StatelessWidget {


  TextInputType textInputType;
  bool hide;

  FormulaireComponents({
    this.hide=false,
    this.textInputType=TextInputType.emailAddress
});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      obscureText: true,
      decoration: InputDecoration(
        suffixIcon: hide? Icon(Icons.remove_red_eye_rounded) : null,
      ),

    );
  }

}