import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:monitor_vaca/utils/providerUser.dart';
import 'package:monitor_vaca/utils/user.dart';
import 'package:provider/provider.dart';

class ApiService {
  static const String _baseUrl = 'http://54.37.71.94/api';

  static Future<User?> login(String username, String password) async {
    try {
      print("username: $username, password: $password");
      final response = await http.post(
        Uri.parse('$_baseUrl/movil/login/'),
        body: {
          'username': username,
          'password': password,
        },
        
      );
      print("response: $response");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return User.fromJson(jsonResponse['data']);
      } else {
        return null;
      }
    } catch (error) {
      // Imprime el error en la consola.
      print("Error en login: $error");
      // Re-lanza el error si es necesario para que pueda ser manejado más arriba.
      throw error;
    }
  }

  static Future<Map<String, dynamic>?> fetchData(
      BuildContext context, int sensorNumber) async {
    final username =
        Provider.of<UserProvider>(context, listen: false).user?.username ?? '';

    final response =
        await http.post(Uri.parse('$_baseUrl/movil/datos/'), body: {
      'username': username,
      'sensor': sensorNumber.toString(),
    });

    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      // Verifica que 'data' sea un mapa y contenga datos
      if (data != null) {
        return data;
      } else {
        throw Exception('Datos inválidos o no encontrados');
      }
    } else {
      throw Exception('Error al cargar los datos desde la API');
    }
  }
}
