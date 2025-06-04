import 'package:flutter/material.dart';
import 'package:impots_benin/useful/colors.dart';
import 'package:impots_benin/app/components/text_components.dart';

class ObligationListComponent extends StatelessWidget {
  final String txt;
  final String imageAsset;
  final VoidCallback? onTap;

  const ObligationListComponent({
    required this.txt,
    required this.imageAsset,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 0),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: TextComponents(
                txt: txt,
                color: Colors.black87,
                txtSize: 15,
                fw: FontWeight.bold,
                family: "Bold",
              ),
            ),
            Image.asset(
              imageAsset,
              width: 25,
              height: 25,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}
