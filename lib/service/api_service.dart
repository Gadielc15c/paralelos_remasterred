import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  //final String baseUrl = "http://localhost:3000";
  final String baseUrl = 'http://10.0.2.2:3000';

  Map<String, String> _headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  Future<http.Response> createEstudiante(Map<String, dynamic> estudiante) {
    return http.post(
      Uri.parse('$baseUrl/estudiantes'),
      headers: _headers,
      body: json.encode(estudiante),
    );
  }

  Future<http.Response> getEstudiantes() {
    return http.get(Uri.parse('$baseUrl/estudiantes'));
  }

  Future<http.Response> updateEstudiante(
      int id, Map<String, dynamic> estudiante) {
    return http.put(
      Uri.parse('$baseUrl/estudiantes/$id'),
      headers: _headers,
      body: json.encode(estudiante),
    );
  }

  Future<http.Response> deleteEstudiante(int id) {
    return http.delete(Uri.parse('$baseUrl/estudiantes/$id'));
  }

  Future<http.Response> createUsuario(Map<String, dynamic> usuario) {
    return http.post(
      Uri.parse('$baseUrl/usuarios'),
      headers: _headers,
      body: json.encode(usuario),
    );
  }

  Future<http.Response> getUsuarios() {
    return http.get(Uri.parse('$baseUrl/usuarios'));
  }

  Future<http.Response> updateUsuario(int id, Map<String, dynamic> usuario) {
    return http.put(
      Uri.parse('$baseUrl/usuarios/$id'),
      headers: _headers,
      body: json.encode(usuario),
    );
  }

  Future<http.Response> deleteUsuario(int id) {
    return http.delete(Uri.parse('$baseUrl/usuarios/$id'));
  }

  Future<http.Response> login(Map<String, dynamic> credentials) {
    return http.post(
      Uri.parse('$baseUrl/login'),
      headers: _headers,
      body: json.encode(credentials),
    );
  }
}
