import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:impots_benin/useful/colors.dart';

// Tes composants personnalisés
import 'package:impots_benin/app/components/button_components.dart';
import 'package:impots_benin/app/components/space.dart';
import 'package:impots_benin/app/components/text_components.dart';
import 'package:impots_benin/app/modules/pageEcheances/controller/controller.dart';
import 'package:impots_benin/app/modules/pageSimulateur/view/results.dart';
import 'package:impots_benin/useful/colors.dart';
import 'package:impots_benin/global.dart';

// Import ta page finalisation ici
import 'finalisation.dart';

class SimulationPatrimoinePage extends StatefulWidget {
  const SimulationPatrimoinePage({Key? key}) : super(key: key);

  @override
  _SimulationPatrimoinePageState createState() => _SimulationPatrimoinePageState();
}

class _SimulationPatrimoinePageState extends State<SimulationPatrimoinePage> {
  String? simulationType;
  String? token;
  Map<String, dynamic>? currentStep;
  List<Map<String, dynamic>> history = [];

  // Couleurs harmonisées
  final Color primaryColor = const Color(0xFF4A90E2); // Bleu doux
  final Color secondaryColor = const Color(0xFF50E3C2); // Vert pastel
  final Color backgroundColor = const Color(0xFFF5F7FA); // Gris très clair doux
  final Color cardColor = Colors.white;
  final Color textColorPrimary = Colors.black87;
  final Color textColorSecondary = Colors.black54;

  Future<void> startSimulation(String type) async {
    final url = type == 'patrimoine'
        ? '${Global.baseUrl2}/start_patrimoine'
        : '${Global.baseUrl2}/start_impot_revenu';

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'simulation_type': type}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        simulationType = type;
        token = data['token'];
        currentStep = data['step'];
        history.clear();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors du démarrage de la simulation')),
      );
    }
  }

  Future<void> sendAnswer(String stepKey, String answer) async {
    final url = simulationType == 'patrimoine'
        ? '${Global.baseUrl2}/answer_patrimoine'
        : '${Global.baseUrl2}/answer_impot_revenu';

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'token': token,
        'step_key': stepKey,
        'answer': answer,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        history.add({'question': currentStep!['question'], 'answer': answer});

        if (data.containsKey('next_step')) {
          currentStep = data['next_step'];
        } else {
          final montant = data['montant'];
          currentStep = null;

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => Finalisation(montantFinal: montant),
            ),
          );
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors de l’envoi de la réponse')),
      );
    }
  }

  Widget buildQuestion() {
    if (currentStep == null) return Container();

    final type = currentStep!['type'];
    final question = currentStep!['question'];
    final key = currentStep!['key'];
    final options = currentStep!['options'];

    if (type == 'select') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextComponents(
            txt: question,
            fw: FontWeight.bold,
            txtSize: 20,
            color: primaryColor,
          ),
          const SizedBox(height: 12),
          ...options.map<Widget>((opt) {
            return Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              margin: const EdgeInsets.symmetric(vertical: 6),
              elevation: 3,
              child: ListTile(
                title: TextComponents(
                  txt: opt['label'],
                  txtSize: 16,
                  fw: FontWeight.w600,
                  color: textColorPrimary,
                ),
                trailing: Icon(Icons.arrow_forward_ios, size: 18, color: primaryColor),
                onTap: () => sendAnswer(key, opt['value']),
              ),
            );
          }).toList(),
        ],
      );
    } else if (type == 'number') {
      final controller = TextEditingController();
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextComponents(
            txt: question,
            fw: FontWeight.bold,
            txtSize: 20,
            color: primaryColor,
          ),
          const SizedBox(height: 12),
          TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Entrez une valeur",
              labelStyle: TextStyle(color: primaryColor),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: primaryColor, width: 2),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: primaryColor.withOpacity(0.5)),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ButtonComponent(
            txtButton: "Suivant",
            buttonColor: primaryColor,
            textColor: Colors.white,
            borderRadius: 15,
            onPressed: () {
              if (controller.text.isNotEmpty) {
                sendAnswer(key, controller.text);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Veuillez entrer une valeur')),
                );
              }
            },
          ),
        ],
      );
    }

    return Container();
  }

  Widget simulationChoiceCard(String title, String description, String type) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 8,
        shadowColor: primaryColor.withOpacity(0.3),
        color: cardColor,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextComponents(
                txt: title,
                txtSize: 24,
                fw: FontWeight.bold,
                color: textColorPrimary,
              ),
              const SizedBox(height: 12),
              TextComponents(
                txt: description,
                txtSize: 16,
                color: textColorSecondary,
              ),
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.centerRight,
                child: ButtonComponent(
                  txtButton: "Commencer",
                  buttonColor: primaryColor,
                  textColor: Colors.white,
                  borderRadius: 14,
                  onPressed: () => startSimulation(type),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (simulationType != null) {
          setState(() {
            simulationType = null;
            token = null;
            currentStep = null;
            history.clear();
          });
          return false;
        }
        return true;
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          title: TextComponents(
            txt: simulationType == null
                ? "Choisissez une simulation"
                : " ${simulationType == 'patrimoine' ? 'patrimoine' : 'Impôt sur le revenu'}",
            fw: FontWeight.bold,
            txtSize: 18,
            color: Colors.white,
          ),
          backgroundColor: primaryColor,
          elevation: 0,
          centerTitle: true,
          toolbarHeight: 60,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(15),
            ),
          ),
        ),
        body: simulationType == null
            ? ListView(
                padding: const EdgeInsets.symmetric(vertical: 30),
                children: [
                  simulationChoiceCard(
                    "Simulation Impôt sur le Patrimoine",
                    "Simulez vos impôts liés au patrimoine (véhicules, armes, etc.)",
                    'patrimoine',
                  ),
                  simulationChoiceCard(
                    "Simulation Impôt sur le revenu",
                    "Calculez vos impôts liés au revenu avec cette simulation dédiée.",
                    'impot_revenu',
                  ),
                ],
              )
            : SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: buildQuestion(),
              ),
      ),
    );
  }
}
