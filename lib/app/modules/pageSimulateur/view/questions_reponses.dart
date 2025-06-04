import 'package:flutter/material.dart';
import 'package:impots_benin/app/components/button_components.dart';
import 'package:impots_benin/app/components/space.dart';
import 'package:impots_benin/app/components/text_components.dart';
import 'package:impots_benin/app/modules/pageEcheances/controller/controller.dart';
import 'package:impots_benin/app/modules/pageSimulateur/view/results.dart';
import 'package:impots_benin/useful/colors.dart';

class QuestionsReponses extends StatefulWidget {
  const QuestionsReponses({super.key});

  @override
  State<QuestionsReponses> createState() => _QuestionsReponsesState();
}

class _QuestionsReponsesState extends State<QuestionsReponses> {
  final ScrollController _scrollController = ScrollController();

  final List<Map<String, dynamic>> questions = [
    {
      'question': "Quel est votre secteur d'activité ?",
      'reponses': [
        "Activité commerciale",
        "Activité artisanale",
        "Activité libérale",
        "Agriculture",
        "Autres"
      ],
    },
    {
      'question': "Quel est votre chiffre d'affaires annuel ?",
      'reponses': [
        "< 5 Millions",
        "Entre 5 et 10 Millions",
        "Entre 10 et 50 Millions",
        "> 50 Millions"
      ],
    },
    {
      'question': "Combien d’employés avez-vous ?",
      'reponses': [
        "Aucun",
        "1 à 5",
        "6 à 20",
        "Plus de 20"
      ],
    },
  ];

  List<String?> reponsesUtilisateur = [];
  int currentQuestionIndex = 0;

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 150,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  void repondre(int index, String reponse) {
    setState(() {
      if (index < reponsesUtilisateur.length) {
        reponsesUtilisateur[index] = reponse;
      } else {
        reponsesUtilisateur.add(reponse);
        if (currentQuestionIndex < questions.length - 1) {
          currentQuestionIndex++;
          scrollToBottom();
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
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
                  ProgressBar(stepActuel: 3, stepActuel2: 2),
                  h(30),
                  Center(
                    child: TextComponents(
                      txt: "Veuillez répondre aux questions suivantes",
                      fw: FontWeight.bold,
                      family: 'Bold',
                      txtSize: 16,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...List.generate(currentQuestionIndex + 1, (index) {
              final q = questions[index];
              final isSelected = (String option) =>
              index < reponsesUtilisateur.length &&
                  reponsesUtilisateur[index] == option;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextComponents(
                    txt: "Question ${index + 1} : ${q['question']}",
                    fw: FontWeight.w600,
                    family: 'Bold',
                    txtSize: 16,
                  ),
                  h(10),
                  ...q['reponses'].map<Widget>((option) {
                    return GestureDetector(
                      onTap: () => repondre(index, option),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected(option)
                              ? Colors.blue.shade100
                              : Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: isSelected(option)
                                ? Colors.blue
                                : Colors.grey.shade300,
                            width: 1.5,
                          ),
                          boxShadow: isSelected(option)
                              ? [
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.2),
                              offset: const Offset(0, 4),
                              blurRadius: 10,
                            )
                          ]
                              : [],
                        ),
                        child: Row(
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isSelected(option)
                                    ? Colors.blue
                                    : Colors.transparent,
                                border: Border.all(
                                  color: isSelected(option)
                                      ? Colors.blue
                                      : Colors.grey,
                                  width: 2,
                                ),
                              ),
                              child: isSelected(option)
                                  ? const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 16,
                              )
                                  : null,
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: TextComponents(
                                txt: option,
                                fw: FontWeight.w500,
                                txtSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                  h(30),
                ],
              );
            }),
            if (reponsesUtilisateur.length == questions.length)
              Center(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 400),
                        pageBuilder: (_, __, ___) => Results(),
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
                    onPressed: () {
                      print('Réponses : $reponsesUtilisateur');
                      // Exemple de navigation :
                      // Navigator.push(context, MaterialPageRoute(builder: (_) => ResultPage()));
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
