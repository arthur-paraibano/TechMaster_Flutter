import 'package:cadastro_flutter/src/screens/home/home.dart';
import 'package:cadastro_flutter/src/screens/home/list_user.dart';
import 'package:cadastro_flutter/src/screens/load/load_entrer.dart';
import 'package:cadastro_flutter/src/screens/load/loading_overlay.dart';
import 'package:cadastro_flutter/src/services/auth_service.dart';
import 'package:cadastro_flutter/src/util/auth_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class MyChangePassword extends StatefulWidget {
  const MyChangePassword({super.key});

  @override
  State<MyChangePassword> createState() => _MyChangePassword();
}

class _MyChangePassword extends State<MyChangePassword> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final AuthService _authService = AuthService();

  Future<void> redefinir() async {
    try {
      if (_passwordController.text != _confirmPasswordController.text) {
        showTopSnackBar(
          Overlay.of(context),
          const CustomSnackBar.error(message: 'As senhas não coincidem'),
        );
        return;
      }

      LoadingOverlay.show(context);
      final response = await _authService.redefinir(_passwordController.text);
      LoadingOverlay.hide();

      if (response.statusCode == 200 || response.statusCode == 201) {
        showTopSnackBar(
          Overlay.of(context),
          const CustomSnackBar.success(message: 'Senha redefinida.'),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyLoadEnter()),
        );
        LoadingOverlay.hide();
      } else {
        showTopSnackBar(
          Overlay.of(context),
          const CustomSnackBar.error(message: 'Erro ao excluir usuário.'),
        );
      }
    } catch (e) {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(message: 'Erro ao excluir usuário.'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tech Master'),
        backgroundColor: Color(0xFF4A90E2),
        actions: [
          FutureBuilder<String?>(
            future: AuthStorage.getProfile(),
            builder: (context, snapshot) {
              List<PopupMenuEntry<String>> menuItems = [
                const PopupMenuItem<String>(
                  value: 'voltar',
                  child: Text('Voltar'),
                ),
                const PopupMenuItem<String>(value: 'sair', child: Text('Sair')),
              ];

              if (snapshot.hasData &&
                  snapshot.data?.toUpperCase() == 'ADMINISTRADOR') {
                menuItems.insert(
                  0, // Insere no início para manter a ordem
                  const PopupMenuItem<String>(
                    value: 'lista_usuarios',
                    child: Text('Lista de Usuários'),
                  ),
                );
              }

              return PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'lista_usuarios') {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => MyListUser()),
                    );
                  } else if (value == 'voltar') {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => MyHome()),
                    );
                  } else if (value == 'sair') {
                    SystemNavigator.pop();
                  }
                },
                itemBuilder: (BuildContext context) => menuItems,
              );
            },
          ),
        ],
      ),
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
            height: 400,
            decoration: BoxDecoration(
              color: Color.fromRGBO(28, 37, 38, 0.9),
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
                  'Redefinir Senha',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Digite e confirme sua nova senha abaixo.',
                  style: TextStyle(color: Colors.white),
                ),

                const SizedBox(height: 30),
                TextField(
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.white),
                    labelText: 'Senha',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.lock, color: Colors.white),
                  ),
                ),

                const SizedBox(height: 16),

                TextField(
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.white),
                    labelText: 'Confirmar Senha',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.lock, color: Colors.white),
                  ),
                ),

                const SizedBox(height: 50),

                SizedBox(
                  width: 150,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Salvar'),
                    onPressed: () {
                      redefinir();
                    },
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
