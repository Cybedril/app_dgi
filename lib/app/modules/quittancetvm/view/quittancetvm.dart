import 'package:flutter/material.dart';
import 'package:impots_benin/app/components/text_components.dart';
import 'package:impots_benin/useful/colors.dart';

class Quittancetvm extends StatefulWidget {
  const Quittancetvm({super.key});

  @override
  State<Quittancetvm> createState() => _QuittancetvmState();
}

class _QuittancetvmState extends State<Quittancetvm> {
  final _formKey = GlobalKey<FormState>();
  final _immatController = TextEditingController();
  final _anneeController = TextEditingController();
  final _telController = TextEditingController();

  bool isFormValid = false;

  void _validateForm() {
    setState(() {
      isFormValid = _immatController.text.isNotEmpty &&
          _anneeController.text.isNotEmpty &&
          _telController.text.isNotEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
    _immatController.addListener(_validateForm);
    _anneeController.addListener(_validateForm);
    _telController.addListener(_validateForm);
  }

  @override
  void dispose() {
    _immatController.dispose();
    _anneeController.dispose();
    _telController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(75),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: TextComponents(
            txt: "Télécharger quittance TVM",
            fw: FontWeight.bold,
            family: 'Bold',
            txtSize: 18,
            color: Colors.black87,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: TextComponents(
                  txt: "Renseigner le formulaire ci-dessous",
                  txtSize: 16,
                  color: Colors.black,
                  fw: FontWeight.w600,
                  family: 'Bold',
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: TextComponents(
                  txt:
                  "Renseigner l'immatriculation, l'année fiscale payée, et le numéro de téléphone ayant servi de paiement",
                  txtSize: 14,
                  color: Colors.black87,
                  fw: FontWeight.normal,
                  family: 'Regular',
                ),
              ),
              const SizedBox(height: 45),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildTextField(
                      label: "Immatriculation du véhicule",
                      controller: _immatController,
                      hint: "Ex : ABXXXXRB",
                    ),
                    const SizedBox(height: 35),
                    _buildTextField(
                      label: "Année fiscale",
                      controller: _anneeController,
                      hint: "Ex : 2024",
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 35),
                    _buildTextField(
                      label: "Numéro de téléphone",
                      controller: _telController,
                      hint: "Ex : 01XXXXXX",
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 35),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        color: isFormValid ? mainColor : Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: isFormValid
                              ? () {
                            if (_formKey.currentState!.validate()) {
                              print("Formulaire validé");
                            }
                          }
                              : null,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.download, color: Colors.white),
                                SizedBox(width: 10),
                                Text(
                                  "Télécharger",
                                  style: TextStyle(color: Colors.white, fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    String? hint,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: (value) =>
      value == null || value.isEmpty ? "Champ requis" : null,
      style: const TextStyle(fontSize: 15),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        contentPadding: const EdgeInsets.symmetric(vertical: 8),
        isDense: true,
        border: const UnderlineInputBorder(),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: mainColor, width: 2),
        ),
      ),
    );
  }
}
