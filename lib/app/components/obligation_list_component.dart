import 'package:flutter/material.dart';
import 'package:impots_benin/useful/colors.dart';
import 'package:impots_benin/app/components/text_components.dart';

class ObligationListComponent extends StatelessWidget {
  final String txt;
  final String? subtitle;      // <--- nouveau paramètre optionnel
  final String imageAsset;
  final VoidCallback? onTap;

  const ObligationListComponent({
    required this.txt,
    this.subtitle,            // <--- ajouté ici
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextComponents(
                    txt: txt,
                    color: Colors.black87,
                    txtSize: 15,
                    fw: FontWeight.bold,
                    family: "Bold",
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 5),
                    TextComponents(
                      txt: subtitle!,
                      color: Colors.black54,
                      txtSize: 13,
                      fw: FontWeight.normal,
                      family: "Regular",
                    ),
                  ],
                ],
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
