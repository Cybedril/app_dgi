import 'package:flutter/material.dart';
import 'package:impots_benin/app/components/button_components.dart';
import 'package:impots_benin/app/components/space.dart';
import 'package:impots_benin/app/components/text_components.dart';
import 'package:impots_benin/app/modules/pageAccueil/view/pageAccueil.dart';
import 'package:impots_benin/useful/colors.dart';
import 'package:intl/intl.dart';
import 'package:confetti/confetti.dart';
import 'package:lottie/lottie.dart';

class Finalisation extends StatefulWidget {
  const Finalisation({super.key});

  @override
  State<Finalisation> createState() => _FinalisationState();
}

class _FinalisationState extends State<Finalisation> with SingleTickerProviderStateMixin {
  final int montantFinal = 2340500;
  late ConfettiController _confettiController;
  bool showButton = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _confettiController.play(); // Lancer après le rendu
    });

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );

    Future.delayed(const Duration(seconds: 5), () {
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
                      h(40),
                      TextComponents(
                        txt: "Estimation terminée !",
                        fw: FontWeight.bold,
                        txtSize: 22,
                        family: "Bold",
                      ),
                      h(10),
                      TextComponents(
                        txt: "Le montant estimé est de :",
                        txtSize: 16,
                        fw: FontWeight.w500,
                        textAlign: TextAlign.center,
                        family: "Regular",
                      ),
                      h(15),
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
                      h(30),
                      if (showButton)
                        FadeTransition(
                          opacity: _fadeAnimation,
                          child: InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => Pageaccueil()),
                              );
                            },
                            child: ButtonComponent(
                              txtButton: "Terminer",
                              buttonColor: mainColor,
                              textColor: Colors.white,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
