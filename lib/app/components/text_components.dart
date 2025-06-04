import 'package:flutter/material.dart';


class TextComponents extends StatelessWidget{

   Color color;
   double txtSize;
   FontWeight fw;
   TextAlign textAlign;
   String txt;
   String family;
   final TextAlign align;

   TextComponents({

     required this.txt,
     this.color=Colors.black,
     this.txtSize=16,
     this.fw=FontWeight.normal,
     this.textAlign=TextAlign.left,
     this.family="Regular",
     this.align = TextAlign.start,

});


  @override
  Widget build(BuildContext context) {
    return Text(txt, style: TextStyle(
      fontFamily: family,
      color: color,
      fontSize: txtSize,
      fontWeight: fw,
    ),textAlign: textAlign,

    );
  }

}