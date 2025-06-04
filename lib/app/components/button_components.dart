import 'package:flutter/material.dart';
import 'package:impots_benin/useful/colors.dart';

class ButtonComponent extends StatelessWidget {
  final String txtButton;
  final Color buttonColor;
  final Color textColor;
  final VoidCallback? onPressed;

  const ButtonComponent({
    required this.txtButton,
    required this.buttonColor,
    required this.textColor,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Center(
        child: Text(
          txtButton,
          style: TextStyle(
            color: textColor,
            fontSize: 17,
          ),
        ),
      ),
    );
  }
}
