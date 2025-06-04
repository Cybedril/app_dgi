import 'package:flutter/material.dart';
import 'package:impots_benin/app/components/button_components.dart';
import 'package:impots_benin/app/components/space.dart';
import 'package:impots_benin/app/components/text_components.dart';
import 'package:impots_benin/app/modules/changermdp/view/changestate2.dart';
import 'package:impots_benin/app/modules/connexion/view/connexion.dart';
import 'package:impots_benin/useful/colors.dart';

class ChangerMotDePasse extends StatefulWidget {
  const ChangerMotDePasse({super.key});

  @override
  State<ChangerMotDePasse> createState() => _ChangerMotDePasseState();
}

class _ChangerMotDePasseState extends State<ChangerMotDePasse> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  double _passwordStrength = 0.0;
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_updatePasswordStrength);
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _updatePasswordStrength() {
    final password = _passwordController.text;

    setState(() {
      if (password.isEmpty) {
        _passwordStrength = 0.0;
      } else if (password.length < 6) {
        _passwordStrength = 0.25;
      } else if (password.length < 10) {
        _passwordStrength = 0.5;
      } else {
        _passwordStrength = 1.0;
      }
    });
  }

  Color get _strengthColor {
    if (_passwordStrength <= 0.25) return Colors.red;
    if (_passwordStrength <= 0.5) return Colors.orange;
    return Colors.green;
  }

  String get _strengthText {
    if (_passwordStrength <= 0.25) return 'Faible';
    if (_passwordStrength <= 0.5) return 'Moyen';
    return 'Fort';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Form(
          key: _formKey, //  Clé du formulaire pour la validation
          child: Column(
            children: [
              TextComponents(
                txt: "Entrer un nouveau mot de passe",
                txtSize: 22,
                fw: FontWeight.bold,
                family: "Bold",
              ),
              h(20),
              TextComponents(
                txt:
                "Votre nouveau mot de passe doit être différent de l'ancien",
                txtSize: 16,
                textAlign: TextAlign.center,
              ),
              h(30),

              // 🔑 Nouveau mot de passe
              TextFormField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: "Mot de passe",
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() => _obscurePassword = !_obscurePassword);
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Veuillez entrer un mot de passe";
                  } else if (value.length < 8) {
                    return "Le mot de passe doit contenir au moins 8 caractères";
                  }
                  return null;
                },
              ),
              h(10),

              //  Barre de progression force du mot de passe
              LinearProgressIndicator(
                value: _passwordStrength,
                backgroundColor: Colors.grey[300],
                color: _strengthColor,
                minHeight: 6,
              ),
              h(5),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Force : $_strengthText',
                  style: TextStyle(color: _strengthColor),
                ),
              ),
              h(30),

              //  Confirmation du mot de passe
              TextFormField(
                controller: _confirmController,
                obscureText: _obscureConfirm,
                decoration: InputDecoration(
                  labelText: "Confirmer le mot de passe",
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirm
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() => _obscureConfirm = !_obscureConfirm);
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Veuillez confirmer le mot de passe";
                  } else if (value != _passwordController.text) {
                    return "Les mots de passe ne correspondent pas";
                  }
                  return null;
                },
              ),
              h(40),

              //  Bouton Enregistrer
              InkWell(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    //  Si la validation est réussie, naviguer vers la page suivante
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Changestate2()),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Mot de passe enregistré avec succès."),
                      ),
                    );
                    // TODO: Envoyer les données au backend ici
                  } else {
                    //  Si la validation échoue, afficher un message d'erreur
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Veuillez corriger les erreurs."),
                      ),
                    );
                  }
                },
                child: ButtonComponent(
                  txtButton: "Enregistrer",
                  buttonColor: mainColor,
                  textColor: Colors.white,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
