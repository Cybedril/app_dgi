import 'package:flutter/material.dart';
import '/models/obligation.dart';
import 'package:impots_benin/app/components/text_components.dart';

class PageDetailObligation extends StatelessWidget {
  final Obligation obligation;

  const PageDetailObligation({super.key, required this.obligation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Détails de l’obligation'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
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
            offset: Offset(0, 30 * (1 - value)), // slide from bottom
            child: child,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextComponents(
                txt: obligation.name,
                color: Colors.black,
                txtSize: 22,
                fw: FontWeight.bold,
                family: "Bold",
              ),
              const SizedBox(height: 10),
              TextComponents(
                txt: "Type : ${obligation.type}",
                color: Colors.black54,
                txtSize: 16,
                fw: FontWeight.w500,
                family: "Regular",
              ),
              const SizedBox(height: 20),
              TextComponents(
                txt: obligation.description ?? "Pas de description disponible.",
                color: Colors.black87,
                txtSize: 15,
                fw: FontWeight.normal,
                family: "Regular",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
