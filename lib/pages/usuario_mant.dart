import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:paralelos_remasterred/models/models.dart';
import 'package:paralelos_remasterred/vm/usuario_vm.dart';

class UsuariosScreen extends StatefulWidget {
  @override
  _UsuariosScreenState createState() => _UsuariosScreenState();
}

class _UsuariosScreenState extends State<UsuariosScreen> {
  final _formKey = GlobalKey<FormState>();
  Usuario _usuarioActual = Usuario(
    id: null, // Asume que el ID es nullable
    user: '',
    password: '',
    branch: '',
    level: '',
    status: '',
  );
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _cargarUsuarios();
  }

  void _cargarUsuarios() async {
    await Provider.of<UsuarioViewModel>(context, listen: false).fetchUsuarios();
  }

  void _mostrarSnackBar(String mensaje) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(mensaje)));
  }

  void _guardarUsuario() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final usuarioVm = Provider.of<UsuarioViewModel>(context, listen: false);
      if (_isEditing && _usuarioActual.id != null) {
        usuarioVm.updateUsuario(_usuarioActual.id!, _usuarioActual).then((_) {
          _mostrarSnackBar('Usuario actualizado');
          _cargarUsuarios();
        });
      } else {
        usuarioVm.createUsuario(_usuarioActual).then((_) {
          _mostrarSnackBar('Usuario agregado');
          _cargarUsuarios();
        });
      }
      _limpiarFormulario();
    }
  }

  void _editarUsuario(Usuario usuario) {
    setState(() {
      _usuarioActual = usuario;
      _isEditing = true;
    });
  }

  void _eliminarUsuario(int? id) {
    if (id != null) {
      Provider.of<UsuarioViewModel>(context, listen: false)
          .deleteUsuario(id)
          .then((_) {
        _mostrarSnackBar('Usuario eliminado');
        _cargarUsuarios();
      });
    }
  }

  void _limpiarFormulario() {
    setState(() {
      _usuarioActual = Usuario(
        id: null,
        user: '',
        password: '',
        branch: '',
        level: '',
        status: '',
      );
      _isEditing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final usuarioVm = Provider.of<UsuarioViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Gestión de Usuarios')),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    initialValue: _usuarioActual.user,
                    decoration: const InputDecoration(labelText: 'Usuario'),
                    onSaved: (value) => _usuarioActual.user = value ?? '',
                  ),
                  TextFormField(
                    initialValue: _usuarioActual.password,
                    decoration: const InputDecoration(labelText: 'Contraseña'),
                    obscureText: true,
                    onSaved: (value) => _usuarioActual.password = value ?? '',
                  ),
                  TextFormField(
                    initialValue: _usuarioActual.branch,
                    decoration: const InputDecoration(labelText: 'Rama'),
                    onSaved: (value) => _usuarioActual.branch = value ?? '',
                  ),
                  TextFormField(
                    initialValue: _usuarioActual.level,
                    decoration: const InputDecoration(labelText: 'Nivel'),
                    onSaved: (value) => _usuarioActual.level = value ?? '',
                  ),
                  TextFormField(
                    initialValue: _usuarioActual.status,
                    decoration: const InputDecoration(labelText: 'Estado'),
                    onSaved: (value) => _usuarioActual.status = value ?? '',
                  ),
                  ElevatedButton(
                    onPressed: _guardarUsuario,
                    child: Text(_isEditing ? 'Actualizar' : 'Agregar'),
                  ),
                ],
              ),
            ),
          ),
          DataTable(
            columns: const [
              DataColumn(label: Text('Usuario')),
              DataColumn(label: Text('Rama')),
              DataColumn(label: Text('Nivel')),
              DataColumn(label: Text('Estado')),
              DataColumn(label: Text('Acciones')),
            ],
            rows: usuarioVm.usuarios.map((usuario) {
              return DataRow(cells: [
                DataCell(Text(usuario.user)),
                DataCell(Text(usuario.branch)),
                DataCell(Text(usuario.level)),
                DataCell(Text(usuario.status)),
                DataCell(Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => _editarUsuario(usuario),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _eliminarUsuario(usuario.id),
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
