import 'package:flutter/material.dart';
import 'package:impots_benin/useful/colors.dart';
import 'package:impots_benin/app/components/text_components.dart';

class EcheanceListComponent extends StatelessWidget {
  final String titre;
  final String valeurDroite;
  final VoidCallback? onTap;

  const EcheanceListComponent({
    required this.titre,
    required this.valeurDroite,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: TextComponents(
                txt: titre,
                txtSize: 16,
                color: Colors.black87,
                fw: FontWeight.bold,
                family: 'Bold',
              ),
            ),
            TextComponents(
              txt: valeurDroite,
              txtSize: 14,
              color: Colors.red,
              fw: FontWeight.bold,
              family: 'Bold',
            ),
          ],
        ),
      ),
    );
  }
}
