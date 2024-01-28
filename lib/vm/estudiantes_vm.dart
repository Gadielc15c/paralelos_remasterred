import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:paralelos_remasterred/models/models.dart';
import 'package:paralelos_remasterred/service/api_service.dart';

class EstudianteViewModel with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Estudiante> _estudiantes = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<Estudiante> get estudiantes => _estudiantes;
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

  Future fetchEstudiantes() async {
    setLoading(true);
    try {
      var response = await _apiService.getEstudiantes();
      if (response.statusCode == 200) {
        List<dynamic> list = json.decode(response.body);
        _estudiantes = list.map((e) => Estudiante.fromJson(e)).toList();
      } else {
        setErrorMessage('Error al cargar los estudiantes');
      }
    } catch (e) {
      setErrorMessage(e.toString());
    } finally {
      setLoading(false);
    }
  }

  Future createEstudiante(Estudiante estudiante) async {
    setLoading(true);
    try {
      var response = await _apiService.createEstudiante(estudiante.toJson());
      if (response.statusCode == 200) {
        fetchEstudiantes();
      } else {
        setErrorMessage('Error al crear el estudiante');
      }
    } catch (e) {
      setErrorMessage(e.toString());
    } finally {
      setLoading(false);
    }
  }

  Future updateEstudiante(Estudiante estudiante) async {
    setLoading(true);
    try {
      var response = await _apiService.updateEstudiante(
          estudiante.id, estudiante.toJson());
      if (response.statusCode == 200) {
        fetchEstudiantes();
      } else {
        setErrorMessage('Error al actualizar el estudiante');
      }
    } catch (e) {
      setErrorMessage(e.toString());
    } finally {
      setLoading(false);
    }
  }

  Future deleteEstudiante(int id) async {
    setLoading(true);
    try {
      var response = await _apiService.deleteEstudiante(id);
      if (response.statusCode == 200) {
        _estudiantes.removeWhere((estudiante) => estudiante.id == id);
        notifyListeners();
      } else {}
    } catch (e) {
      print("rEste es el error${e}");
    } finally {
      setLoading(false);
    }
  }
}
