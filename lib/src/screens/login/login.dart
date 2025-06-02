import 'dart:convert';

import 'package:cadastro_flutter/src/models/error.dart';
import 'package:cadastro_flutter/src/models/login.dart';
import 'package:cadastro_flutter/src/screens/home/home.dart';
import 'package:cadastro_flutter/src/screens/load/loading_overlay.dart';
import 'package:cadastro_flutter/src/screens/register/cadastra.dart';
import 'package:cadastro_flutter/src/services/auth_service.dart';
import 'package:cadastro_flutter/src/util/auth_storage.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class MyLogin extends StatelessWidget {
  MyLogin({super.key});

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final authService = AuthService();

  Future<void> _login(BuildContext context) async {
    if (_usernameController.text.isEmpty || _passwordController.text.isEmpty) {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(message: 'Preencha todos os campos'),
      );
      return;
    }

    LoadingOverlay.show(context);

    try {
      final loginResponse = await authService.Logalte(
        Login(
          username: _usernameController.text.toUpperCase(),
          password: _passwordController.text,
        ),
      );

      await AuthStorage.saveLoginData(
        token: loginResponse.token,
        id: loginResponse.id,
        name: loginResponse.name,
        email: loginResponse.email,
        profile: loginResponse.profile,
      );

      LoadingOverlay.hide();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyHome()),
      );
    } catch (e) {
      LoadingOverlay.hide();
      ErrorMessage errorMessage = ErrorMessage.fromJson(
        jsonDecode(e.toString().replaceFirst('Exception: ', ''))
            as Map<String, dynamic>,
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
            padding: const EdgeInsets.all(30),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, 10),
                  blurRadius: 20,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Tech Master',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),

                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Usuário',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.person),
                  ),
                ),
                const SizedBox(height: 16),

                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.lock),
                  ),
                ),
                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: const Color(0xFF4A90E2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      _login(context);
                    },
                    child: const Text(
                      'Entrar',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: const BorderSide(color: Color(0xFF4A90E2)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => MyCadastro()),
                      );
                    },
                    child: const Text(
                      'Criar Cadastro',
                      style: TextStyle(fontSize: 16, color: Color(0xFF4A90E2)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
