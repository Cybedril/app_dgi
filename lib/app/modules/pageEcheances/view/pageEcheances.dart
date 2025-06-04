import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:impots_benin/app/components/echeance_list_components.dart';
import 'package:impots_benin/app/components/space.dart';
import 'package:impots_benin/app/components/text_components.dart';
import 'package:impots_benin/useful/colors.dart';

class Pageecheances extends StatefulWidget {
  const Pageecheances({super.key});

  @override
  State<Pageecheances> createState() => _PageecheancesState();
}

class _PageecheancesState extends State<Pageecheances> with TickerProviderStateMixin {
  final List<String> months = [
    'Tout', 'Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin',
    'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre'
  ];

  int selectedMonthIndex = 0;

  late final AnimationController _controller;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _slideAnimation = Tween<Offset>(begin: const Offset(0.0, 0.1), end: Offset.zero).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    SchedulerBinding.instance.addPostFrameCallback((_) {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(180),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          flexibleSpace: SafeArea(
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: TextComponents(
                      txt: 'Échéances',
                      txtSize: 24,
                      color: Colors.black87,
                      fw: FontWeight.bold,
                      family: 'Bold',
                    ),
                  ),
                ),
                Positioned(
                  top: 27,
                  right: 16,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      padding: const EdgeInsets.all(15),
                      icon: const Icon(
                        Icons.notifications_none,
                        color: Colors.black87,
                        size: 27,
                      ),
                      onPressed: () {
                        // Action sur la cloche
                      },
                    ),
                  ),
                ),
                Positioned(
                  bottom: 25,
                  left: 0,
                  right: 0,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: months.map((month) {
                        int index = months.indexOf(month);
                        final bool isSelected = selectedMonthIndex == index;

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedMonthIndex = index;
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              height: 45,
                              decoration: BoxDecoration(
                                color: isSelected ? mainColor : Colors.grey[100],
                                borderRadius: BorderRadius.circular(50),
                                boxShadow: isSelected
                                    ? [BoxShadow(color: mainColor.withOpacity(0.2), blurRadius: 5, offset: Offset(0, 5))]
                                    : [],
                              ),
                              child: Center(
                                child: TextComponents(
                                  txt: month,
                                  color: isSelected ? Colors.white : Colors.black87,
                                  family: isSelected ? 'Bold' : 'Regular',
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        color: backgroundApp,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child: SlideTransition(
            position: _slideAnimation,
            child: Column(
              children: [
                _buildEcheanceItem('Déclaration TVA', '15 Avril'),
                _buildEcheanceItem('Paiement IS', '20 Avril'),
                _buildEcheanceItem('Déclaration Impôt sur le revenu', '31 Mars'),
                _buildEcheanceItem('Paiement Taxe professionnelle', '10 Mai'),
                _buildEcheanceItem('Déclaration des salaires', '05 Avril'),
                _buildEcheanceItem('Versement des retenues à la source', '18 Avril'),
                _buildEcheanceItem('Déclaration des opérations internationales', '25 Avril'),
                _buildEcheanceItem('Déclaration CNSS', '30 Avril'),
                _buildEcheanceItem('Déclaration FNRB', '10 Juin'),
                _buildEcheanceItem('Paiement Contribution des patentes', '15 Juillet'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEcheanceItem(String title, String dueDate) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: TextComponents(
          txt: title,
          fw: FontWeight.bold,
          txtSize: 16,
          color: Colors.black87,
        ),
        subtitle: TextComponents(
          txt: 'Échéance : $dueDate',
          fw: FontWeight.w400,
          txtSize: 14,
          color: Colors.red,
        ),
        trailing: Icon(
          Icons.alarm,
          color: mainColor,
          size: 30,
        ),
      ),
    );
  }
}
