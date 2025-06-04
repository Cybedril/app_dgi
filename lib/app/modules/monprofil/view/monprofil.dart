import 'package:flutter/material.dart';
import 'package:impots_benin/app/components/button_components.dart';
import 'package:impots_benin/app/components/formulaire_components.dart';
import 'package:impots_benin/app/components/space.dart';
import 'package:impots_benin/app/components/text_components.dart';
import 'package:impots_benin/useful/colors.dart';

class Monprofil extends StatefulWidget {
  const Monprofil({super.key});

  @override
  State<Monprofil> createState() => _MonprofilState();
}

class _MonprofilState extends State<Monprofil> {
  final TextEditingController nomController = TextEditingController();
  final TextEditingController prenomController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: TextComponents(
          txt: "Mon profil",
          fw: FontWeight.bold,
          family: 'Bold',
          txtSize: 20,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            h(20),
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: mainColor.withOpacity(0.2),
                    child: const Icon(
                      Icons.person,
                      size: 60,
                      color: Colors.white,
                    ),
                  ),
                  h(15),
                  TextComponents(
                    txt: "Prénom Nom",
                    family: "Bold",
                    txtSize: 22,
                  ),
                ],
              ),
            ),
            h(40),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildInputField(
                    controller: nomController,
                    label: "Nom",
                  ),
                  h(20),
                  _buildInputField(
                    controller: prenomController,
                    label: "Prénom",
                  ),
                ],
              ),
            ),
            h(40),
            Center(
              child: ButtonComponent(
                txtButton: "Enregistrer",
                buttonColor: mainColor,
                textColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({required TextEditingController controller, required String label}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextComponents(
          txt: label,
          family: 'Bold',
          txtSize: 16,
        ),
        h(10),
        TextField(
          controller: controller,
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFF0F2F5),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}