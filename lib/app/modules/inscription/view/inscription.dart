import 'package:flutter/material.dart';
import 'package:impots_benin/app/components/button_components.dart';
import 'package:impots_benin/app/components/space.dart';
import 'package:impots_benin/app/components/text_components.dart';
import 'package:impots_benin/app/modules/connexion/view/connexion.dart';
import 'package:impots_benin/app/modules/inscription/view/success.dart';
import 'package:impots_benin/useful/colors.dart';

class Inscription extends StatefulWidget {
  const Inscription({super.key});

  @override
  State<Inscription> createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> with SingleTickerProviderStateMixin {
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  bool _obscurePassword = true;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  String? _emailError;
  String? _passwordError;
  String? _phoneError;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 700),
    );

    _slideAnimation = Tween<Offset>(begin: Offset(0, 0.2), end: Offset.zero).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Validation email avec regex
  bool _isEmailValid(String email) {
    String pattern =
        r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$";
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(email);
  }

  // Validation mot de passe
  bool _isPasswordValid(String password) {
    return password.length >= 8;
  }

  // Validation numéro de téléphone
  bool _isPhoneValid(String phone) {
    return phone.length == 10 && RegExp(r'^[0-9]+$').hasMatch(phone);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundApp,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(350),
        child: AppBar(
          backgroundColor: backgroundApp,
          elevation: 0,
          automaticallyImplyLeading: false,
          flexibleSpace: SafeArea(
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  top: 10,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.blueAccent),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                Positioned(
                  top: 25,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: TextComponents(
                      txt: "Créer un compte",
                      txtSize: 16,
                      fw: FontWeight.bold,
                      family: "Bold",
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 2),
                    child: Image.asset(
                      'assets/images/inscription.png',
                      height: 300,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(40),
              child: SlideTransition(
                position: _slideAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),

                      // Email
                      TextFormField(
                        controller: _emailController,
                        focusNode: _emailFocus,
                        decoration: InputDecoration(
                          labelText: "Email",
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          labelStyle: TextStyle(color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.blueAccent, width: 2),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                      if (_emailError != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            _emailError!,
                            style: TextStyle(color: Colors.red, fontSize: 12),
                          ),
                        ),
                      SizedBox(height: 30),

                      // Numéro de téléphone
                      TextFormField(
                        controller: _phoneController,
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                        decoration: InputDecoration(
                          labelText: "Numéro de téléphone",
                          counterText: "",
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          labelStyle: TextStyle(color: Colors.grey),
                          prefix: Padding(
                            padding: EdgeInsets.only(right: 8),
                            child: Text("+229", style: TextStyle(fontSize: 16, color: Colors.black)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.blueAccent, width: 2),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                      if (_phoneError != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            _phoneError!,
                            style: TextStyle(color: Colors.red, fontSize: 12),
                          ),
                        ),
                      SizedBox(height: 30),

                      // Mot de passe
                      TextFormField(
                        controller: _passwordController,
                        focusNode: _passwordFocus,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          labelText: "Mot De Passe",
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          labelStyle: TextStyle(color: Colors.grey),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword ? Icons.visibility_off : Icons.visibility,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.blueAccent, width: 2),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                      if (_passwordError != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            _passwordError!,
                            style: TextStyle(color: Colors.red, fontSize: 12),
                          ),
                        ),
                      SizedBox(height: 30),

                      InkWell(
                        onTap: () {
                          setState(() {
                            _emailError = null;
                            _passwordError = null;
                            _phoneError = null;
                          });

                          // Vérification des champs
                          if (_emailController.text.isEmpty ||
                              !_isEmailValid(_emailController.text)) {
                            setState(() {
                              _emailError = "Email invalide";
                            });
                            return;
                          }

                          if (_phoneController.text.isEmpty ||
                              !_isPhoneValid(_phoneController.text)) {
                            setState(() {
                              _phoneError = "Numéro de téléphone invalide";
                            });
                            return;
                          }

                          if (_passwordController.text.isEmpty ||
                              !_isPasswordValid(_passwordController.text)) {
                            setState(() {
                              _passwordError = "Le mot de passe doit contenir au moins 8 caractères";
                            });
                            return;
                          }

                          // Si tout est valide, aller à la page suivante
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Success()));
                        },
                        child: ButtonComponent(
                          txtButton: "Confirmer",
                          buttonColor: mainColor,
                          textColor: Colors.white,
                        ),
                      ),
                      SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextComponents(
                            txt: "Avez-vous déjà un compte ?  ",
                            color: Colors.black87,
                            txtSize: 12,
                            fw: FontWeight.bold,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Connexion(),));
                            },
                            child: TextComponents(
                              txt: "Connectez-vous",
                              color: Colors.blueAccent,
                              txtSize: 12,
                              fw: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
