import 'package:flutter/material.dart';
import 'package:paralelos_remasterred/pages/estudiantes_mant.dart';
import 'package:paralelos_remasterred/pages/usuario_mant.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Inicio'),
              Tab(text: 'Usuarios'),
              Tab(text: 'Estudiantes'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            InicioTab(),
            UsuariosTab(),
            EstudiantesTab(),
          ],
        ),
      ),
    );
  }
}

class InicioTab extends StatelessWidget {
  const InicioTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Contenido de Inicio'));
  }
}

class UsuariosTab extends StatelessWidget {
  const UsuariosTab({super.key});

  @override
  Widget build(BuildContext context) {
    return UsuariosScreen();
  }
}

class EstudiantesTab extends StatelessWidget {
  const EstudiantesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return EstudiantesScreen();
  }
}
