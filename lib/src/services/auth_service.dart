import 'dart:convert';

import 'package:cadastro_flutter/src/models/login.dart';
import 'package:cadastro_flutter/src/models/login_response.dart';
import 'package:cadastro_flutter/src/models/registar.dart';
import 'package:cadastro_flutter/src/util/auth_storage.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl = 'https://backend-cadastro-prod.onrender.com';

  Future<LoginResponse> Logalte(Login login) async {
    try {
      final url = Uri.parse('$baseUrl/auth/login');
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'name': login.username,
          'password': login.password,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return LoginResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Erro ao fazer login: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao fazer login: $e');
    }
  }

  Future<http.Response> Registra(Registar enty) async {
    try {
      final url = Uri.parse('$baseUrl/auth/create');
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'id': '0',
          'name': enty.name,
          'email': enty.email,
          'password': enty.password,
          'cpf': enty.cpf,
          'profile': enty.profile,
        }),
      );

      return response;
    } catch (e) {
      throw Exception('Erro ao criar registro: $e');
    }
  }

  Future<http.Response> Listar() async {
    try {
      final token = await AuthStorage.getToken();
      if (token == null) {
        throw Exception('Token de autenticação não encontrado');
      }
      final url = Uri.parse('$baseUrl/user/all');
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      return response;
    } catch (e) {
      throw Exception('Erro ao listar registros: $e');
    }
  }

  Future<http.Response> Deletar(int id) async {
    try {
      final token = await AuthStorage.getToken();
      if (token == null) {
        throw Exception('Token de autenticação não encontrado');
      }
      final url = Uri.parse('$baseUrl/user/delete');
      final response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, String>{'id': id.toString()}),
      );
      return response;
    } catch (e) {
      throw Exception('Erro ao deletar registro: $e');
    }
  }

  Future<http.Response> redefinir(String password) async {
    try {
      final id = await AuthStorage.getId();
      final name = await AuthStorage.getName();
      final token = await AuthStorage.getToken();
      if (token == null) {
        throw Exception('Token de autenticação não encontrado');
      }
      final url = Uri.parse('$baseUrl/user/update-password');
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, String>{
          'id': id.toString(),
          'name': name.toString(),
          'password': password.toString(),
        }),
      );
      return response;
    } catch (e) {
      throw Exception('Erro ao deletar registro: $e');
    }
  }
}
