import 'dart:convert';

import 'package:cadastro_flutter/src/models/error.dart';
import 'package:cadastro_flutter/src/models/registar.dart';
import 'package:cadastro_flutter/src/screens/load/loading_overlay.dart';
import 'package:cadastro_flutter/src/screens/login/login.dart';
import 'package:cadastro_flutter/src/services/auth_service.dart';
import 'package:cadastro_flutter/src/util/validator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class MyCadastro extends StatefulWidget {
  MyCadastro({super.key});

  @override
  State<MyCadastro> createState() => _MyCadastroState();
}

class _MyCadastroState extends State<MyCadastro> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final authService = AuthService();
  String _perfilValue = 'Usuário';

  Future<void> _register(BuildContext context) async {
    if (_usernameController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _cpfController.text.isEmpty ||
        _perfilValue.isEmpty) {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(message: 'Preencha todos os campos'),
      );
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(message: 'As senhas não coincidem'),
      );
      return;
    }

    // Validação do CPF
    String? cpfError = Validator.validateCpf(_cpfController.text);
    if (cpfError != null) {
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(message: cpfError),
      );
      return;
    }

    // Validação do e-mail (opcional: exigir Gmail)
    String? emailError = Validator.validateEmail(
      _emailController.text,
      requireGmail: false,
    );
    if (emailError != null) {
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(message: emailError),
      );
      return;
    }

    LoadingOverlay.show(context);

    Response response = await authService.Registra(
      Registar(
        name: _usernameController.text.toUpperCase(),
        email: _emailController.text.toUpperCase(),
        password: _passwordController.text,
        cpf: _cpfController.text,
        profile: _perfilValue.toUpperCase(),
      ),
    );

    LoadingOverlay.hide();

    if (response.statusCode == 201 || response.statusCode == 200) {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.success(message: 'Cadastro realizado com sucesso'),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyLogin()),
      );
    } else {
      ErrorMessage errorMessage = ErrorMessage.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>,
      );
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(message: errorMessage.message.toString()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4A90E2), Color(0xFF50C9C3)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Container(
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            height: 680,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromRGBO(0, 0, 0, 0.3),
                  offset: Offset(0, 10),
                  blurRadius: 20,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Cadastre-se',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 16),

                TextField(
                  style: TextStyle(fontWeight: FontWeight.bold),
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(),
                    labelText: 'Nome',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: Icon(Icons.person),
                  ),
                ),

                const SizedBox(height: 16),

                TextField(
                  style: TextStyle(fontWeight: FontWeight.bold),
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(),
                    labelText: 'E-mail',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(),
                    ),
                    prefixIcon: Icon(Icons.email),
                  ),
                ),

                const SizedBox(height: 16),

                TextField(
                  style: TextStyle(fontWeight: FontWeight.bold),
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(),
                    labelText: 'Senha',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(),
                    ),
                    prefixIcon: Icon(Icons.lock),
                  ),
                ),

                const SizedBox(height: 16),

                TextField(
                  style: TextStyle(fontWeight: FontWeight.bold),
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(),
                    labelText: 'Confirmar Senha',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(),
                    ),
                    prefixIcon: Icon(Icons.lock),
                  ),
                ),

                const SizedBox(height: 16),

                TextField(
                  style: TextStyle(fontWeight: FontWeight.bold),
                  controller: _cpfController,
                  decoration: InputDecoration(
                    labelText: 'CPF',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: Icon(Icons.badge),
                  ),
                ),
                const SizedBox(height: 16),

                Container(
                  margin: EdgeInsets.symmetric(horizontal: 2),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: _perfilValue,
                    dropdownColor: Colors.white,
                    onChanged: (String? value) {
                      setState(() {
                        _perfilValue = value!;
                      });
                    },
                    items: [
                      DropdownMenuItem(
                        value: 'Usuário',
                        child: Text(
                          'Usuário',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'Administrador',
                        child: Text(
                          'Administrador',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    iconEnabledColor: Colors.black,
                  ),
                ),

                const SizedBox(height: 16),

                SizedBox(
                  width: 150,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: const Color(0xFF4A90E2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () => _register(context),
                    child: const Text(
                      'Cadastrar',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Já possui uma conta?',
                      style: TextStyle(color: Colors.black),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyLogin()),
                        );
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(color: Color(0xFF4A90E2)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
