import 'package:flutter/material.dart';
import 'package:impots_benin/app/components/button_components.dart';
import 'package:impots_benin/app/components/space.dart';
import 'package:impots_benin/app/components/text_components.dart';
import 'package:impots_benin/app/modules/pageAccueil/view/pageAccueil.dart';
import 'package:impots_benin/useful/colors.dart';
import 'package:impots_benin/app/modules/pageSimulateur/view/pageSimulateur.dart';
import 'package:intl/intl.dart';
import 'package:confetti/confetti.dart';
import 'package:lottie/lottie.dart';

class Finalisation extends StatefulWidget {
  final int montantFinal;
  const Finalisation({Key? key, required this.montantFinal}) : super(key: key);

  @override
  State<Finalisation> createState() => _FinalisationState();
}

class _FinalisationState extends State<Finalisation> with SingleTickerProviderStateMixin {
  late ConfettiController _confettiController;
  bool showButton = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _confettiController.play();
    });

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        showButton = true;
        _animationController.forward();
      });
    });
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final montantFinal = widget.montantFinal;
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFe6f0ff), Color(0xFFffffff)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Container(
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Lottie.asset(
                        'assets/lottie/success.json',
                        width: 150,
                        height: 150,
                        fit: BoxFit.contain,
                        repeat: false,
                      ),
                      const SizedBox(height: 40),
                      const Text(
                        "Estimation terminée !",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Le montant estimé est de :",
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 15),
                      TweenAnimationBuilder<double>(
                        duration: const Duration(seconds: 5),
                        tween: Tween(begin: 0.0, end: montantFinal.toDouble()),
                        builder: (context, value, child) {
                          final formatCurrency = NumberFormat.decimalPattern('fr_FR');
                          return Text(
                            "${formatCurrency.format(value.toInt())} FCFA",
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: mainColor,
                            ),
                            textAlign: TextAlign.center,
                          );
                        },
                      ),
                      const SizedBox(height: 30),
                     if (showButton)
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: mainColor,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                          ),
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => const Pageaccueil()),
                              (route) => false,
                            );
                          },
                          child: const Text(
                            "Terminer",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: const [Colors.green, Colors.blue, Colors.pink, Colors.orange, Colors.purple],
              emissionFrequency: 0.05,
              numberOfParticles: 20,
              maxBlastForce: 20,
              minBlastForce: 10,
              gravity: 0.1,
            ),
          )
        ],
      ),
    );
  }
}
