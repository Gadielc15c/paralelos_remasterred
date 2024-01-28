import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:paralelos_remasterred/models/models.dart';
import 'package:paralelos_remasterred/vm/estudiantes_vm.dart';

class EstudiantesScreen extends StatefulWidget {
  @override
  _EstudiantesScreenState createState() => _EstudiantesScreenState();
}

class _EstudiantesScreenState extends State<EstudiantesScreen> {
  final _formKey = GlobalKey<FormState>();
  late Estudiante _estudianteActual;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _estudianteActual = _nuevoEstudiante();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cargarEstudiantes();
    });
  }

  Estudiante _nuevoEstudiante() {
    return Estudiante(
      id: 0,
      name: '',
      lastName: '',
      career: '',
      branch: '',
      varkEstilosAprendizaje: {
        'visual': 0,
        'auditivo': 0,
        'lectura_escritura': 0,
        'kinestésico': 0
      },
    );
  }

  void _cargarEstudiantes() async {
    await Provider.of<EstudianteViewModel>(context, listen: false)
        .fetchEstudiantes();
  }

  void _mostrarSnackBar(String mensaje) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(mensaje)));
  }

  void _guardarEstudiante() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final estudianteVm =
          Provider.of<EstudianteViewModel>(context, listen: false);
      if (_isEditing) {
        estudianteVm.updateEstudiante(_estudianteActual).then((_) {
          _mostrarSnackBar('Estudiante actualizado');
          _cargarEstudiantes();
        });
      } else {
        estudianteVm.createEstudiante(_estudianteActual).then((_) {
          _mostrarSnackBar('Estudiante agregado');
          _cargarEstudiantes();
        });
      }
      _limpiarFormulario();
    }
  }

  void _editarEstudiante(Estudiante estudiante) {
    setState(() {
      _estudianteActual = estudiante;
      _isEditing = true;
    });
  }

  void _eliminarEstudiante(int id) {
    Provider.of<EstudianteViewModel>(context, listen: false)
        .deleteEstudiante(id)
        .then((_) {
      _mostrarSnackBar('Estudiante eliminado');
      _limpiarFormulario();
      _cargarEstudiantes();
    });
  }

  void _limpiarFormulario() {
    setState(() {
      _estudianteActual = _nuevoEstudiante();
      _isEditing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final estudianteVm = Provider.of<EstudianteViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Gestión de Estudiantes')),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    initialValue: _estudianteActual.name,
                    decoration: const InputDecoration(labelText: 'Nombre'),
                    onSaved: (value) => _estudianteActual.name = value ?? 'VACIO',
                  ),
                  TextFormField(
                    initialValue: _estudianteActual.lastName,
                    decoration: const InputDecoration(labelText: 'Apellido'),
                    onSaved: (value) =>
                        _estudianteActual.lastName = value ?? 'VACIO',
                  ),
                  TextFormField(
                    initialValue: _estudianteActual.career,
                    decoration: const InputDecoration(labelText: 'Carrera'),
                    onSaved: (value) => _estudianteActual.career = value ?? 'ISC',
                  ),
                  TextFormField(
                    initialValue: _estudianteActual.branch,
                    decoration: const InputDecoration(labelText: 'Rama'),
                    onSaved: (value) => _estudianteActual.branch = value ?? 'UTESA',
                  ),
                  ..._estudianteActual.varkEstilosAprendizaje.keys.map((key) {
                    return TextFormField(
                      initialValue: _estudianteActual
                          .varkEstilosAprendizaje[key]
                          .toString(),
                      decoration: InputDecoration(labelText: 'Estilo $key'),
                      keyboardType: TextInputType.number,
                      onSaved: (value) {
                        if (value != null && value.isNotEmpty) {
                          _estudianteActual.varkEstilosAprendizaje[key] =
                              int.tryParse(value) ?? 0;
                        }
                      },
                    );
                  }).toList(),
                  ElevatedButton(
                    onPressed: _guardarEstudiante,
                    child: Text(_isEditing ? 'Actualizar' : 'Agregar'),
                  ),
                ],
              ),
            ),
          ),
          DataTable(
            columns: const [
              DataColumn(label: Text('Nombre')),
              DataColumn(label: Text('Apellido')),
              DataColumn(label: Text('Carrera')),
              DataColumn(label: Text('Rama')),
              DataColumn(label: Text('Estilos de Aprendizaje')),
              DataColumn(label: Text('Acciones')),
            ],
            rows: estudianteVm.estudiantes.map((estudiante) {
              return DataRow(cells: [
                DataCell(Text(estudiante.name)),
                DataCell(Text(estudiante.lastName)),
                DataCell(Text(estudiante.career)),
                DataCell(Text(estudiante.branch)),
                DataCell(
                    Text(estudiante.varkEstilosAprendizaje.values.join(', '))),
                DataCell(Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => _editarEstudiante(estudiante),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _eliminarEstudiante(estudiante.id),
                    ),
                  ],
                )),
              ]);
            }).toList(),
          ),
        ],
      ),
    );
  }
}
