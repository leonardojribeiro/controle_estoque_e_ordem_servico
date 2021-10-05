import 'package:controle_de_estoque_e_os/modules/auth/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Column(
        children: [
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: 'Email',
            ),
          ),
          TextFormField(
            controller: passwordController,
            decoration: InputDecoration(
              labelText: 'Senha',
            ),
          ),
          OutlinedButton(
            onPressed: () {
              Modular.get<AuthController>().signInWithEmailAndPassword(
                email: emailController.text,
                password: passwordController.text,
              );
            },
            child: Text('Login'),
          ),
        ],
      ),
    );
  }
}
