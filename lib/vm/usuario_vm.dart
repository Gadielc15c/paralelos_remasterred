import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:paralelos_remasterred/models/models.dart';
import 'package:paralelos_remasterred/service/api_service.dart';

class UsuarioViewModel with ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<Usuario> _usuarios = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<Usuario> get usuarios => _usuarios;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void setErrorMessage(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  Future<void> _handleApiCall(Future<void> Function() apiCall) async {
    setLoading(true);
    try {
      await apiCall();
    } catch (e) {
      setErrorMessage(e.toString());
    } finally {
      setLoading(false);
    }
  }

  Future fetchUsuarios() async {
    await _handleApiCall(() async {
      var response = await _apiService.getUsuarios();
      if (response.statusCode == 200) {
        List<dynamic> list = json.decode(response.body);
        _usuarios = list.map((e) => Usuario.fromJson(e)).toList();
      } else {
        throw Exception('Error al cargar los usuarios');
      }
    });
  }

  Future createUsuario(Usuario usuario) async {
    setLoading(true);
    try {
      var response = await _apiService.createUsuario(usuario.toJson());
      if (response.statusCode == 200) {
        fetchUsuarios();
      } else {
        setErrorMessage('Error al crear el usuario');
      }
    } catch (e) {
      setErrorMessage(e.toString());
    } finally {
      setLoading(false);
    }
  }

  Future updateUsuario(int id, Usuario usuario) async {
    setLoading(true);
    try {
      var response = await _apiService.updateUsuario(id, usuario.toJson());
      if (response.statusCode == 200) {
        fetchUsuarios();
      } else {
        setErrorMessage('Error al actualizar el usuario');
      }
    } catch (e) {
      setErrorMessage(e.toString());
    } finally {
      setLoading(false);
    }
  }

  Future deleteUsuario(int id) async {
    setLoading(true);
    try {
      var response = await _apiService.deleteUsuario(id);
      if (response.statusCode == 200) {
        fetchUsuarios();
      } else {
        setErrorMessage('Error al eliminar el usuario');
      }
    } catch (e) {
      setErrorMessage(e.toString());
    } finally {
      setLoading(false);
    }
  }

  Future<bool> login(Map<String, dynamic> credentials) async {
    setLoading(true);
    try {
      var response = await _apiService.login(credentials);
      if (response.statusCode == 200) {
        setLoading(false);
        return true; // Inicio de sesión exitoso
      } else {
        setErrorMessage('Error al iniciar sesión');
      }
    } catch (e) {
      setErrorMessage(e.toString());
    } finally {
      setLoading(false);
    }
    return false; // Inicio de sesión fallido
  }
}
