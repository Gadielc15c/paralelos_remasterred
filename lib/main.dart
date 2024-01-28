import 'package:flutter/material.dart';
import 'package:paralelos_remasterred/pages/login_page.dart';
import 'package:paralelos_remasterred/vm/estudiantes_vm.dart';
import 'package:paralelos_remasterred/vm/usuario_vm.dart';

import 'package:provider/provider.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UsuarioViewModel()),
        ChangeNotifierProvider(create: (_) => EstudianteViewModel()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(
            title:
                'Flutter Demo Home Page'), 
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return LoginPage();
  }
}
