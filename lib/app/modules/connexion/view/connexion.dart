import 'package:flutter/material.dart';
import 'package:impots_benin/app/components/button_components.dart';
import 'package:impots_benin/app/components/space.dart';
import 'package:impots_benin/app/components/text_components.dart';
import 'package:impots_benin/app/modules/inscription/view/inscription.dart';
import 'package:impots_benin/app/modules/motDePasseOublie/view/motDePasseOublie.dart';
import 'package:impots_benin/app/modules/pageAccueil/view/pageAccueil.dart';
import 'package:impots_benin/useful/colors.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:impots_benin/global.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


Future<bool> login(String email, String password) async {
  final url = Uri.parse('${Global.baseUrl}/login');
  //final url = Uri.parse('http://127.0.0.1:8000/api/v1/login');
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'email': email,
      'password': password,
    }),
  );

  if (response.statusCode == 201 || response.statusCode == 200) {
    // Succès
    final data = jsonDecode(response.body);
    final token = data['token'];

    // 🔐 Sauvegarde ici
    final storage = FlutterSecureStorage();
    await storage.write(key: 'auth_token', value: token);

    return true;
  } else {
    // Affiche l’erreur dans la console pour debug
    print('Erreur: ${response.body}');
    return false;
  }
}

class Connexion extends StatefulWidget {
  const Connexion({super.key});

  @override
  State<Connexion> createState() => _ConnexionState();
}

class _ConnexionState extends State<Connexion> with SingleTickerProviderStateMixin {
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  bool _obscurePassword = true;

   TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  String? _emailError;
  String? _passwordError;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 700),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_animationController);

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

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
                      txt: "Bon Retour !",
                      txtSize: 16,
                      fw: FontWeight.bold,
                      family: "Bold",
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Image.asset(
                      'assets/images/connexion.png',
                      height: 550,
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
                    TextComponents(
                      txt: "Connectez-vous maintenant ...",
                      fw: FontWeight.bold,
                      family: "Bold",
                      txtSize: 21,
                    ),
                    SizedBox(height: 40),

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


                    h(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextComponents(txt: "Se souvenir de moi", color: Colors.black87, txtSize: 13,),
                        InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => motDePasseOublie(),));
                            },
                            child: TextComponents(txt: "Mot De Passe Oublié ?", color: Colors.blueAccent, txtSize: 13, fw: FontWeight.bold, )),
                      ],
                    ),
                    h(30),
                    InkWell(
                      onTap: () async {
                          setState(() {
                            _emailError = null;
                            _passwordError = null;
                          });

                          // Validations...
                          if (_emailController.text.isEmpty || !_isEmailValid(_emailController.text)) {
                            setState(() { _emailError = "Email invalide"; });
                            return;
                          }
                          if (_passwordController.text.isEmpty || !_isPasswordValid(_passwordController.text)) {
                            setState(() { _passwordError = "Le mot de passe doit contenir au moins 8 caractères"; });
                            return;
                          }

                          // Appel API
                          bool success = await login(
                            _emailController.text,
                            _passwordController.text,
                          );

                          if (success) {
                            //redirection vers page accueil
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Pageaccueil(),));
                            
                          }
                          else{
                              // Affiche une erreur à l’utilisateur
                              ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Erreur lors de la connexion. Veuillez réessayer.")),
                            );
                          }
                      },
                        child: ButtonComponent(txtButton: "Se connecter", buttonColor: mainColor, textColor: Colors.white, )),
                        h(40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextComponents(txt: "Vous n'avez pas de compte ?  ", color: Colors.black87, txtSize: 12, fw: FontWeight.bold,),
                            InkWell(
                                onTap: () {
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Inscription(),));
                                },
                                child: TextComponents(txt: "Créez un compte", color: Colors.blueAccent, txtSize: 12, fw: FontWeight.bold, )),
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