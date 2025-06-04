import 'package:flutter/material.dart';
import 'package:impots_benin/app/modules/splash/controller/controller.dart';
import 'package:impots_benin/useful/colors.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    // TODO: implement initState
    time(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: Center(
        child: Container(
          height: 250,
          width: 300,
          child: Column(
            children: [
              Image.asset("assets/images/logo.png", scale: 2.4 ,),

            ]

          ),

        ),
      ),
    );
  }
}
