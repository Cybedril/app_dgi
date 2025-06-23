import 'package:flutter/material.dart';
import 'package:impots_benin/app/components/space.dart';
import 'package:impots_benin/app/components/text_components.dart';
import 'package:impots_benin/app/modules/quittancetvm/view/quittancetvm.dart';
import 'package:impots_benin/useful/colors.dart';

class Pagedocument extends StatefulWidget {
  const Pagedocument({super.key});

  @override
  State<Pagedocument> createState() => _PagedocumentState();
}

class _PagedocumentState extends State<Pagedocument> {
  String _selectedDoc = 'TVM';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundApp,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),
            Center(
              child: TextComponents(
                txt: 'Mes documents fiscaux',
                txtSize: 22,
                color: Colors.black87,
                fw: FontWeight.bold,
                family: 'Bold',
              ),
            ),
            const SizedBox(height: 35),
            TextComponents(
              txt: 'Besoin d’un document fiscal ?',
              txtSize: 16,
              color: Colors.black,
              fw: FontWeight.normal,
              family: 'Regular',
            ),
            const SizedBox(height: 10),
            TextComponents(
              txt: 'Téléchargez vos quittances, attestations, etc.',
              txtSize: 15,
              color: Colors.black,
              fw: FontWeight.normal,
              family: 'Regular',
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'assets/images/documents.png',
                  scale: 7,
                ),
              ),
            ),
            h(30),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Sélectionner un document',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8), // Espace entre le texte et le champ
                  DropdownButtonFormField<String>(
                    value: _selectedDoc,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[100],
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    icon: Icon(Icons.arrow_drop_down, color: Colors.grey[700]),
                    items: ['TVM', 'IFU'].map((doc) {
                      return DropdownMenuItem(
                        value: doc,
                        child: Text(doc),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedDoc = value!;
                      });
                    },
                  ),
                ],
              ),
            ),

            h(20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GestureDetector(
                onTap: () {
                  if (_selectedDoc == 'TVM') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Quittancetvm()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Page IFU pas encore disponible")),
                    );
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      SizedBox(width: 10),
                      Text(
                        'Suivant ',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
