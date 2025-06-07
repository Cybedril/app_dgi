import 'package:flutter/material.dart';
import '/models/obligation.dart';
import 'package:impots_benin/useful/colors.dart';
import 'package:impots_benin/app/components/text_components.dart';

class PageDetailObligation extends StatelessWidget {
  final Obligation obligation;

  const PageDetailObligation({super.key, required this.obligation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundApp,
      appBar: AppBar(
        title: const Text('Détails de l’obligation'),
        backgroundColor: backgroundApp,
        foregroundColor: Colors.black87,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 500),
        tween: Tween(begin: 0.0, end: 1.0),
        builder: (context, value, child) => Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 30 * (1 - value)),
            child: child,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 4,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.gavel_rounded, color: mainColor),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextComponents(
                          txt: obligation.name,
                          color: Colors.black,
                          txtSize: 22,
                          fw: FontWeight.bold,
                          family: "Bold",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Icon(Icons.account_balance_wallet, color: Colors.black54),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextComponents(
                          txt: "Contribuables : ${obligation.type}",
                          color: Colors.black54,
                          txtSize: 16,
                          fw: FontWeight.w500,
                          family: "Regular",
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 30, thickness: 1),
                  TextComponents(
                    txt: "Description",
                    color: Colors.black,
                    txtSize: 18,
                    fw: FontWeight.bold,
                    family: "Bold",
                  ),
                  const SizedBox(height: 10),
                  TextComponents(
                    txt: obligation.description.isNotEmpty
                        ? obligation.description
                        : "Pas de description disponible.",
                    color: Colors.black87,
                    txtSize: 15,
                    fw: FontWeight.normal,
                    family: "Regular",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
