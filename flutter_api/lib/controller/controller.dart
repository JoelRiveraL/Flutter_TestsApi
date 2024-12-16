import 'dart:convert'; // Para json.decode
import 'package:http/http.dart' as http;
import '../model/model.dart'; // Importa el modelo User

class ApiController {
  final String baseUrl = "https://reqres.in/api";

  // Método para obtener los usuarios
  Future<List<User>> obtenerUsuarios() async {
    final response = await http.get(Uri.parse("$baseUrl/users?page=2"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['data'] as List).map((item) => User.fromJson(item)).toList();
    } else {
      throw Exception('Error al obtener los usuarios: ${response.statusCode}');
    }
  }

  // Método para actualizar un usuario
  Future<Map<String, dynamic>> actualizarUsuario(
      int id, String name, String job) async {
    final response = await http.put(
      Uri.parse("$baseUrl/users/$id"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "name": name,
        "job": job,
      }),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al actualizar el usuario: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> obtenerUsuario(int userId) async {
    final url =
        Uri.parse('$baseUrl/users/$userId'); // Reemplaza con tu ruta de API

    final response = await http.get(url);

    if (response.statusCode == 200) {
      // Si la solicitud fue exitosa, parseamos los datos
      return json.decode(response.body);
    } else {
      throw Exception('Error al obtener los detalles del usuario');
    }
  }

  // Método para crear un nuevo usuario
  Future<Map<String, dynamic>> crearUsuario(String name, String job) async {
    final response = await http.post(
      Uri.parse("$baseUrl/users"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "name": name,
        "job": job,
      }),
    );

    if (response.statusCode == 201) {
      return json.decode(response.body); // Retorna los datos del usuario creado
    } else {
      throw Exception('Error al crear el usuario: ${response.statusCode}');
    }
  }

}
