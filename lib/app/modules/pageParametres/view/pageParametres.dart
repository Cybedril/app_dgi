import 'package:flutter/material.dart';
import 'package:impots_benin/app/components/space.dart';
import 'package:impots_benin/app/components/text_components.dart';
import 'package:impots_benin/app/modules/connexion/view/connexion.dart';
import 'package:impots_benin/app/modules/monprofil/view/monprofil.dart';
import 'package:impots_benin/useful/colors.dart';

class Pageparametres extends StatefulWidget {
  const Pageparametres({super.key});

  @override
  State<Pageparametres> createState() => _PageparametresState();
}

class _PageparametresState extends State<Pageparametres> {
  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: TextComponents(txt: "Confirmation",
            txtSize: 20,
            family: 'Bold',
            fw: FontWeight.bold ,),
          content: const Text("Voulez-vous vraiment vous déconnecter ?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: TextComponents(txt: "Annuler", txtSize: 14, color: mainColor,family: 'Bold', fw: FontWeight.bold,),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: mainColor,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: InkWell(
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Connexion(),));
                } ,
                child: TextComponents(txt: "Se déconnecter",
                  color: Colors.white,
                  fw: FontWeight.bold,
                  family: 'Bold',
                  txtSize: 14,),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: TextComponents(
          txt: "Paramètres",
          fw: FontWeight.bold,
          family: 'Bold',
          txtSize: 20,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          h(15),
          _buildSettingCard(
            icon: Icons.person,
            iconColor: Colors.blueAccent,
            title: "Mon profil",
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Monprofil(),));
            },
          ),
          h(12),
          _buildSettingCard(
            icon: Icons.notifications_active,
            iconColor: Colors.orange,
            title: "Notifications",
            onTap: () {
              // Action à définir
            },
          ),
          h(12),
          _buildSettingCard(
            icon: Icons.logout,
            iconColor: Colors.redAccent,
            title: "Se déconnecter",
            onTap: _showLogoutDialog,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: iconColor.withOpacity(0.1),
              radius: 22,
              child: Icon(icon, color: iconColor, size: 22),
            ),
            w(16),
            Expanded(
              child: TextComponents(
                txt: title,
                txtSize: 16,
                fw: FontWeight.w500,
                family: "Medium",
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
