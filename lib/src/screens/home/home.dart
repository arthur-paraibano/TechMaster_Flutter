import 'package:cadastro_flutter/src/screens/home/list_user.dart';
import 'package:cadastro_flutter/src/screens/reset/change_password.dart';
import 'package:cadastro_flutter/src/util/auth_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  String usuario = '';
  String? perfil;

  @override
  void initState() {
    super.initState();
    _loadDados();
  }

  Future<void> _loadDados() async {
    final name = await AuthStorage.getName();
    final userProfile = await AuthStorage.getProfile();
    setState(() {
      usuario = name ?? 'Usuário desconhecido';
      perfil = userProfile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tech Master'),
        backgroundColor: Color(0xFF4A90E2),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'redefinir_senha') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MyChangePassword()),
                );
              } else if (value == 'lista_usuarios') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MyListUser()),
                );
              } else if (value == 'sair') {
                SystemNavigator.pop();
              }
            },
            itemBuilder: (BuildContext context) {
              List<PopupMenuEntry<String>> menuItems = [
                const PopupMenuItem<String>(
                  value: 'redefinir_senha',
                  child: Text('Redefinir Senha'),
                ),
                const PopupMenuItem<String>(value: 'sair', child: Text('Sair')),
              ];

              if (perfil?.toUpperCase() == 'ADMINISTRADOR') {
                menuItems.insert(
                  1,
                  const PopupMenuItem<String>(
                    value: 'lista_usuarios',
                    child: Text('Lista de Usuários'),
                  ),
                );
              }

              return menuItems;
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
            height: 300,
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Hola Mundo!',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Bem-vindo, $usuario',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
