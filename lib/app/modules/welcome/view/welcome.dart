import 'package:flutter/material.dart';
import 'package:impots_benin/app/components/button_components.dart';
import 'package:impots_benin/app/components/space.dart';
import 'package:impots_benin/app/components/text_components.dart';
import 'package:impots_benin/app/modules/connexion/view/connexion.dart';
import 'package:impots_benin/app/modules/inscription/view/inscription.dart';
import 'package:impots_benin/useful/colors.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundApp,
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 35, right: 35),
        color: backgroundApp,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            TextComponents(
              txt: "Bienvenue",
              txtSize: 35,
              fw: FontWeight.bold,
              family: "Bold",
            ),
            Image.asset("assets/images/Welcome.png", scale: 6),
            h(40),

            AnimatedButton(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Inscription()),
                );
              },
              child: ButtonComponent(
                txtButton: "Inscription",
                buttonColor: mainColor,
                textColor: Colors.white,
              ),
            ),

            h(20),

            AnimatedButton(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Connexion()),
                );
              },
              child: ButtonComponent(
                txtButton: "Connexion",
                buttonColor: loginButtonColor,
                textColor: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AnimatedButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;

  const AnimatedButton({super.key, required this.child, required this.onTap});

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> with SingleTickerProviderStateMixin {
  double _scale = 1.0;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _scale = 0.95;
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _scale = 1.0;
    });
    widget.onTap();
  }

  void _onTapCancel() {
    setState(() {
      _scale = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 100),
        child: widget.child,
      ),
    );
  }
}
