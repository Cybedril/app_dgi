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

// CONTENU PRINCIPAL DE LA PAGE ACCUEIL
class PageaccueilContent extends StatefulWidget {
  const PageaccueilContent({super.key});

  @override
  State<PageaccueilContent> createState() => _PageaccueilContentState();
}

class _PageaccueilContentState extends State<PageaccueilContent> {
  TextEditingController _searchController = TextEditingController();
  int _currentIndex = 0;

  final List<String> imageList = [
    'assets/images/baniere.png',
    'assets/images/baniere3.png',
  ];

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
          child: SingleChildScrollView(
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
                AnimationLimiter(
                  child: Column(
                    children: List.generate(5, (index) {
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 400),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: Column(
                              children: [
                                ObligationListComponent(
                                  txt: "Obligation ${index + 1 }",
                                  imageAsset: 'assets/images/right.png',
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                const SizedBox(height: 20),
                TextComponents(
                  txt: "Obligation 2",
                  txtSize: 18,
                  color: mainColor,
                  family: "Bold",
                  fw: FontWeight.bold,
                ),
                const SizedBox(height: 20),
                AnimationLimiter(
                  child: Column(
                    children: List.generate(4, (index) {
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 400),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: Column(
                              children: [
                                ObligationListComponent(
                                  txt: "Obligation 2-${index + 1}",
                                  imageAsset: 'assets/images/right.png',
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
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
