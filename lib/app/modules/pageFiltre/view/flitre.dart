import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:impots_benin/app/modules/pageAccueil/view/page_detail_obligation.dart';
import 'package:impots_benin/app/components/text_components.dart';
import 'package:impots_benin/useful/colors.dart';
import 'package:impots_benin/app/components/obligation_list_component.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:impots_benin/global.dart';
import '/models/obligation.dart';

class Flitre extends StatefulWidget {
  const Flitre({super.key});

  @override
  State<Flitre> createState() => _FlitreState();
}

class _FlitreState extends State<Flitre> {
  final List<String> categories = [
    "Tout",
    "Particulier",
    "Entreprise",
    "Ong",
    "Representant Fiscale",
  ];

  final Map<String, String> categoryApiMapping = {
    "Tout": "",
    "Particulier": "particulier",
    "Entreprise": "entreprise",
    "Ong": "ong",
    "Representant Fiscale": "representant",
  };

  int selectedCategoryIndex = 0;
  List<Obligation> obligations = [];
  bool isLoading = false;

  Future<void> fetchObligations(String category) async {
    final storage = FlutterSecureStorage();
    final token = await storage.read(key: 'auth_token');

    setState(() {
      isLoading = true;
      obligations = [];
    });

    try {
      Map<String, dynamic> bodyData = {};
      String apiType = categoryApiMapping[category] ?? '';
      if (apiType.isNotEmpty) {
        bodyData['type'] = apiType;
      }

      final response = await http.post(
        Uri.parse('${Global.baseUrl}/obligations/search'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(bodyData),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> list = data["data"] ?? [];
        setState(() {
          obligations = list.map((item) => Obligation.fromJson(item)).toList();
        });
      } else {
        print('Erreur serveur : ${response.statusCode}');
        print('Corps réponse : ${response.body}');
      }
    } catch (e) {
      print('Erreur réseau : $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchObligations(categories[0]); // Charge "Tout" au démarrage
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: backgroundApp,
        elevation: 1,
        centerTitle: true,
        title: TextComponents(
          txt: "Filtrer les obligations",
          fw: FontWeight.bold,
          family: "Bold",
          txtSize: 20,
        ),
        leading: IconButton(
          icon: Icon(Icons.filter_list, color: mainColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TextComponents(
                txt: "Catégories",
                fw: FontWeight.w600,
                family: "Bold",
                txtSize: 17,
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final bool isSelected = selectedCategoryIndex == index;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: ChoiceChip(
                    label: Text(
                      category,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black87,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    selected: isSelected,
                    selectedColor: mainColor,
                    backgroundColor: Colors.grey[200],
                    onSelected: (_) {
                      setState(() {
                        selectedCategoryIndex = index;
                      });
                      fetchObligations(category);
                    },
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : obligations.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.info_outline, size: 40, color: Colors.grey),
                          SizedBox(height: 10),
                          Text(
                            "Aucune obligation trouvée.",
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                        ],
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: obligations.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          final obligation = obligations[index];
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 2,
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(12),
                              title: Text(
                                obligation.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 18),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    transitionDuration: const Duration(milliseconds: 300),
                                    pageBuilder: (_, __, ___) =>
                                        PageDetailObligation(obligation: obligation),
                                    transitionsBuilder: (_, animation, __, child) {
                                      return FadeTransition(
                                        opacity: animation,
                                        child: child,
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
