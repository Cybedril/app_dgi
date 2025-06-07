import 'package:flutter/material.dart';

class ButtonComponent extends StatelessWidget {
  final String txtButton;
  final Color buttonColor;
  final Color textColor;
  final VoidCallback? onPressed;
  final double borderRadius;
  final double paddingHorizontal;
  final double paddingVertical;

  const ButtonComponent({
    required this.txtButton,
    required this.buttonColor,
    required this.textColor,
    this.onPressed,
    this.borderRadius = 7,
    this.paddingHorizontal = 20,
    this.paddingVertical = 14,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: paddingHorizontal,
          vertical: paddingVertical,
        ),
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Center(
          child: Text(
            txtButton,
            style: TextStyle(
              color: textColor,
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
