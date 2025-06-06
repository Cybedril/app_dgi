import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:impots_benin/app/components/button_components.dart';
import 'package:impots_benin/app/components/obligation_list_component.dart';
import 'package:impots_benin/app/components/space.dart';
import 'package:impots_benin/app/components/text_components.dart';
import 'package:impots_benin/app/modules/messagerieChatbot/view/messagerieChatbot.dart';
import 'package:impots_benin/app/modules/pageFiltre/view/flitre.dart';
import 'package:impots_benin/useful/colors.dart';
import 'package:impots_benin/app/components/custom_bottom_nav_bar.dart';

// IMPORT DES AUTRES PAGES
import 'package:impots_benin/app/modules/pageDocument/view/pageDocument.dart';
import 'package:impots_benin/app/modules/pageEcheances/view/pageEcheances.dart';
import 'package:impots_benin/app/modules/pageParametres/view/pageParametres.dart';
import 'package:impots_benin/app/modules/pageSimulateur/view/pageSimulateur.dart';
import 'package:impots_benin/app/modules/pageAccueil/view/page_detail_obligation.dart';

import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '/models/obligation.dart';
import 'package:impots_benin/global.dart';

Future<List<Obligation>> fetchObligations() async {
  final storage = FlutterSecureStorage();
  final token = await storage.read(key: 'auth_token');

  final url = Uri.parse('${Global.baseUrl}/obligations');

  final response = await http.get(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    final jsonBody = json.decode(response.body);

    // Accès à la clé 'data' qui contient la liste
    final List<dynamic> data = jsonBody['data'];

    return data.map((e) => Obligation.fromJson(e)).toList();
  } else {
    throw Exception('Erreur lors du chargement des obligations');
  }
}


// ----- ObligationListComponent corrigé -----
class ObligationListComponent extends StatelessWidget {
  final String txt;
  final String subtitle;
  final String imageAsset;
  final VoidCallback? onTap;

  const ObligationListComponent({
    required this.txt,
    required this.subtitle,
    required this.imageAsset,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 0),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextComponents(
                    txt: txt,
                    color: Colors.black87,
                    txtSize: 15,
                    fw: FontWeight.bold,
                    family: "Bold",
                  ),
                  const SizedBox(height: 5),
                  TextComponents(
                    txt: subtitle,
                    color: Colors.grey[600]!,
                    txtSize: 13,
                    fw: FontWeight.normal,
                    family: "Regular",
                  ),
                ],
              ),
            ),
            Image.asset(
              imageAsset,
              width: 25,
              height: 25,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}

// ----- Pageaccueil et PageaccueilContent -----
class Pageaccueil extends StatefulWidget {
  const Pageaccueil({super.key});

  @override
  State<Pageaccueil> createState() => _PageaccueilState();
}

class _PageaccueilState extends State<Pageaccueil> {
  int _currentPage = 0;

  final List<Widget> _pages = const [
    PageaccueilContent(),
    Pageecheances(),
    Pagesimulateur(),
    Pagedocument(),
    Pageparametres(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundApp,
      body: Stack(
        children: [
          Container(
            color: backgroundApp,
            child: _pages[_currentPage],
          ),
          if (_currentPage == 0)
            Positioned(
              bottom: 20,
              right: 20,
              child: FloatingActionButton.extended(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 400),
                      pageBuilder: (_, __, ___) => Messageriechatbot(),
                      transitionsBuilder: (_, animation, __, child) {
                        return ScaleTransition(
                          scale: CurvedAnimation(parent: animation, curve: Curves.easeInOut),
                          child: child,
                        );
                      },
                    ),
                  );
                },
                backgroundColor: mainColor,
                icon: const Icon(Icons.chat, color: Colors.white),
                label: const Text(
                  "Chat avec nous",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Bold",
                  ),
                ),
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _currentPage,
        onTabChange: (index) {
          setState(() {
            _currentPage = index;
          });
        },
      ),
    );
  }
}

class PageaccueilContent extends StatefulWidget {
  const PageaccueilContent({super.key});

  @override
  State<PageaccueilContent> createState() => _PageaccueilContentState();
}

class _PageaccueilContentState extends State<PageaccueilContent> {
  TextEditingController _searchController = TextEditingController();
  int _currentIndex = 0;
  List<Obligation> obligations = [];
  bool isLoading = true;

  final List<String> imageList = [
    'assets/images/baniere.png',
    'assets/images/baniere3.png',
  ];

  @override
  void initState() {
    super.initState();
    loadObligations();
  }

  Future<void> loadObligations() async {
  try {
    final data = await fetchObligations();
    print("Obligations reçues: ${data.length}");
    for (var o in data) {
      print(" - ${o.name} (${o.type})");
    }
    setState(() {
      obligations = data;
      isLoading = false;
    });
  } catch (e) {
    print("Erreur: $e");
    setState(() {
      isLoading = false;
    });
  }
}



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PreferredSize(
          preferredSize: const Size.fromHeight(180),
          child: AppBar(
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            elevation: 0,
            flexibleSpace: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 40, 15, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 9,
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: TextComponents(
                                    txt: "Que recherchez-vous ?",
                                    color: Colors.black45,
                                    txtSize: 15,
                                    fw: FontWeight.bold,
                                    family: "Bold",
                                  ),
                                ),
                                const Spacer(),
                                const Padding(
                                  padding: EdgeInsets.only(right: 15),
                                  child: Icon(
                                    Icons.search,
                                    color: Colors.black87,
                                    size: 27,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            padding: const EdgeInsets.all(16),
                            icon: const Icon(
                              Icons.notifications_none,
                              color: Colors.black87,
                              size: 27,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(right: 15, left: 10),
                          child: TextComponents(
                            txt: "Obligations fiscales 2025",
                            color: Colors.black87,
                            txtSize: 16,
                            fw: FontWeight.bold,
                            family: "Bold",
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(
                            Icons.tune_sharp,
                            color: Colors.black87,
                            size: 29,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation, secondaryAnimation) => Flitre(),
                                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                  const begin = Offset(1.0, 0.0);
                                  const end = Offset.zero;
                                  const curve = Curves.ease;

                                  final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                                  return SlideTransition(
                                    position: animation.drive(tween),
                                    child: child,
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          CarouselSlider(
                            options: CarouselOptions(
                              height: 200,
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 4),
                              enlargeCenterPage: true,
                              viewportFraction: 1.0,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _currentIndex = index;
                                });
                              },
                            ),
                            items: imageList.map((imagePath) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.asset(
                                      imagePath,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                          ),
                          Positioned(
                            bottom: 10,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: imageList.asMap().entries.map((entry) {
                                    return Container(
                                      width: 8.0,
                                      height: 8.0,
                                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: _currentIndex == entry.key
                                            ? Colors.white
                                            : Colors.white.withOpacity(0.5),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const SizedBox(height: 20),
                      AnimationLimiter(
                        child: Column(
                          children: obligations.map((obligation) {
                            return AnimationConfiguration.staggeredList(
                              position: obligations.indexOf(obligation),
                              duration: const Duration(milliseconds: 400),
                              child: SlideAnimation(
                                verticalOffset: 50.0,
                                child: FadeInAnimation(
                                  child: Column(
                                    children: [
                                      ObligationListComponent(
                                      txt: obligation.name,
                                      subtitle: obligation.type,
                                      imageAsset: 'assets/images/right.png',
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                            transitionDuration: const Duration(milliseconds: 400),
                                            pageBuilder: (_, __, ___) => PageDetailObligation(obligation: obligation),
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
                                    const SizedBox(height: 10),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ],
    );
  }
}
