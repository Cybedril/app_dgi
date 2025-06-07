import 'package:flutter/material.dart';
import 'package:impots_benin/app/components/button_components.dart';
import 'package:impots_benin/app/components/space.dart';
import 'package:impots_benin/app/components/text_components.dart';
import 'package:impots_benin/app/modules/pageEcheances/controller/controller.dart';
import 'package:impots_benin/app/modules/pageSimulateur/unused/nature_impot.dart';
import 'package:impots_benin/useful/colors.dart';

class SecteurActivite extends StatefulWidget {
  const SecteurActivite({super.key});

  @override
  State<SecteurActivite> createState() => _SecteurActiviteState();
}

class _SecteurActiviteState extends State<SecteurActivite>
    with TickerProviderStateMixin {
  String? selectedSecteurActivite;

  List<String> secteurActivite = [
    'Secteur 1',
    'Secteur 2',
    'Secteur 3',
    'Secteur 4',
    'Secteur 5',
    'Secteur 6',
    'Secteur 7',
  ];

  late final List<AnimationController> _controllers = [];
  late final List<Animation<Offset>> _animations = [];
  late final List<Animation<double>> _fadeAnimations = [];

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < secteurActivite.length; i++) {
      final controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 1500),
      );

      final slideAnimation = Tween<Offset>(
        begin: const Offset(0, 0.3),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: controller,
        curve: Curves.easeOut,
      ));

      final fadeAnimation = Tween<double>(
        begin: 0,
        end: 1,
      ).animate(CurvedAnimation(
        parent: controller,
        curve: Curves.easeIn,
      ));

      _controllers.add(controller);
      _animations.add(slideAnimation);
      _fadeAnimations.add(fadeAnimation);

      // Délai progressif
      Future.delayed(Duration(milliseconds: i * 100), () {
        if (mounted) controller.forward();
      });
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundApp,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(200),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: TextComponents(
            txt: "Simulateur",
            fw: FontWeight.bold,
            family: 'Bold',
            txtSize: 18,
          ),
          flexibleSpace: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 70),
                  ProgressBar(stepActuel: 1, stepActuel2: 0),
                  h(30),
                  Center(
                    child: TextComponents(
                      txt: "Veuillez choisir un secteur d'activité ",
                      fw: FontWeight.bold,
                      family: 'Bold',
                      txtSize: 17,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
            child: Column(
              children: List.generate(secteurActivite.length, (index) {
                final secteur = secteurActivite[index];
                final isSelected = selectedSecteurActivite == secteur;

                return SlideTransition(
                  position: _animations[index],
                  child: FadeTransition(
                    opacity: _fadeAnimations[index],
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            selectedSecteurActivite = secteur;
                          });
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Colors.blue.shade50
                                : Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.15),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                            border: Border.all(
                              color: isSelected
                                  ? Colors.blue
                                  : Colors.transparent,
                              width: 1.5,
                            ),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            leading: CircleAvatar(
                              backgroundColor: Colors.blue.shade100,
                              child: Icon(Icons.work, color: Colors.blue),
                            ),
                            title: TextComponents(
                              txt: secteur,
                              fw: FontWeight.w600,
                              txtSize: 15,
                            ),
                            trailing: Radio<String>(
                              value: secteur,
                              groupValue: selectedSecteurActivite,
                              activeColor: Colors.blue,
                              onChanged: (value) {
                                setState(() {
                                  selectedSecteurActivite = value;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionDuration: const Duration(milliseconds: 400),
                    pageBuilder: (_, __, ___) => NatureImpot(),
                    transitionsBuilder: (_, animation, __, child) {
                      return ScaleTransition(
                        scale: CurvedAnimation(parent: animation, curve: Curves.easeInOut),
                        child: child,
                      );
                    },
                  ),
                );
              },



              child: ButtonComponent(
                txtButton: 'Suivant',
                buttonColor: mainColor,
                textColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
