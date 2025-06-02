import 'dart:convert';

import 'package:cadastro_flutter/src/screens/home/home.dart';
import 'package:cadastro_flutter/src/screens/load/loading_overlay.dart';
import 'package:cadastro_flutter/src/services/auth_service.dart';
import 'package:cadastro_flutter/src/util/auth_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class MyListUser extends StatefulWidget {
  const MyListUser({super.key});

  @override
  State<MyListUser> createState() => _MyListUserState();
}

class _MyListUserState extends State<MyListUser> {
  final AuthService _authService = AuthService();
  List<Map<String, dynamic>> _users = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    try {
      final response = await _authService.Listar();
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          _users = data.cast<Map<String, dynamic>>();
          _isLoading = false;
        });
      } else {
        throw Exception('Erro ao carregar usuários');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _deleteUser(int id) async {
    try {
      final idGet = await AuthStorage.getId();
      if (idGet == id) {
        showTopSnackBar(
          Overlay.of(context),
          const CustomSnackBar.error(
            message: 'Não é possivel excluir o usuário logado.',
          ),
        );
        return;
      }

      LoadingOverlay.show(context);
      final response = await _authService.Deletar(id);
      LoadingOverlay.hide();

      if (response.statusCode == 200 || response.statusCode == 201) {
        setState(() {
          _users.removeWhere((user) => user['id'] == id);
        });
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

  Widget _buildTableHeaders() {
    const headerStyle = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
      child: Row(
        children: [
          Expanded(flex: 3, child: Text('NOME', style: headerStyle)),
          Expanded(flex: 4, child: Text('E-MAIL', style: headerStyle)),
          Expanded(
            flex: 2,
            child: Text(
              'AÇÕES',
              style: headerStyle,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserDataRow(Map<String, dynamic> userData) {
    const dataStyle = TextStyle(color: Colors.white, fontSize: 12);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              userData['name'] ?? '',
              style: dataStyle,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              userData['email'] ?? '',
              style: dataStyle,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: ElevatedButton(
                onPressed: () => _deleteUser(userData['id']),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(35, 35),
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text(
                  'X',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0070C0),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 12),
              textStyle: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MyHome()),
              );
            },
            child: const Text('Voltar'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6c757d),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 12),
              textStyle: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              SystemNavigator.pop();
            },
            child: const Text('Sair'),
          ),
        ],
      ),
    );
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
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 15),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            constraints: BoxConstraints(
              minHeight: 400,
              maxHeight: MediaQuery.of(context).size.height * 0.8,
            ),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(28, 37, 38, 0.93),
              borderRadius: BorderRadius.circular(25),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.3),
                  offset: Offset(0, 10),
                  blurRadius: 20,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Painel do Administrador',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 15),
                _buildTableHeaders(),
                Divider(color: Colors.white.withOpacity(0.2), height: 1),
                Expanded(
                  child:
                      _isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : ListView.separated(
                            itemCount: _users.length,
                            itemBuilder: (context, index) {
                              return _buildUserDataRow(_users[index]);
                            },
                            separatorBuilder:
                                (context, index) => Divider(
                                  color: Colors.white.withOpacity(0.15),
                                  height: 1,
                                  thickness: 1,
                                ),
                          ),
                ),
                _buildBottomButtons(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
