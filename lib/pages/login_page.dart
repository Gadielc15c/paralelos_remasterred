import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:paralelos_remasterred/models/models.dart';
import 'package:paralelos_remasterred/pages/home_screen.dart';
import 'package:paralelos_remasterred/vm/usuario_vm.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
   Duration get loginTime => const  Duration(milliseconds: 2250);

  Future<String?> _authUser(LoginData data, BuildContext context) async {
    final usuarioVm = Provider.of<UsuarioViewModel>(context, listen: false);
    try {
      bool? result = await usuarioVm.login({
        'user': data.name,
        'password': data.password,
      });

      if (result == true) {
        return null; 
      } else {
        return 'Usuario o contraseña incorrecta'; 
      }
    } catch (e) {
      return 'Error durante el inicio de sesión';
    }
  }

  Future<String?> _signupUser(SignupData data, BuildContext context) async {
    final usuarioVm = Provider.of<UsuarioViewModel>(context, listen: false);
    bool result = await usuarioVm.createUsuario(Usuario(
      user: data.name ?? '',
      password: data.password ?? '',
      branch: 'UTESA',
      level: 'Estudiante',
      status: '0',
    ));
    if (result) {
      return null;
    }
    return 'Error al registrar el usuario';
  }

  String? _validarUsuario(String? username) {
    if (username == null || username.isEmpty) {
      return 'El nombre de usuario no puede estar vacío';
    }
    return null;
  }

  void _navegarPostLogin(BuildContext context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const HomeScreen(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'APP',
      onLogin: (data) => _authUser(data, context),
      userType: LoginUserType.name,
      userValidator: _validarUsuario,
      onSignup: (data) => _signupUser(data, context),
      onSubmitAnimationCompleted: () => _navegarPostLogin(context),
      onRecoverPassword: (_) => Future.value(''),
      messages: LoginMessages(
        userHint: 'Usuario',
        passwordHint: 'Contraseña',
        confirmPasswordHint: 'Confirmar contraseña',
        loginButton: 'INICIAR SESIÓN',
        signupButton: 'REGISTRARSE',
        forgotPasswordButton: '¿Olvidaste tu contraseña?',
        recoverPasswordButton: 'AYUDA',
        goBackButton: 'ATRÁS',
        confirmPasswordError: 'Las contraseñas no coinciden',
      ),
      theme: LoginTheme(
        primaryColor: Colors.teal,
        accentColor: Colors.yellow,
        errorColor: Colors.deepOrange,
      ),
    );
  }
}
