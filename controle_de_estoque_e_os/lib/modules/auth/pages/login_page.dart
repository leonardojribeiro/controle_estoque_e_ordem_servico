import 'package:controle_de_estoque_e_os/modules/auth/auth_controller.dart';
import 'package:flutter/gestures.dart';
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
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 360),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlinedButton(
                        onPressed: () {
                          Modular.get<AuthController>().signInWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text,
                          );
                        },
                        child: Text('Login'),
                      ),
                    ),
                  ),
                  Divider(),
                  Text.rich(
                    TextSpan(
                      text: 'Não tem um login? ',
                      children: [
                        TextSpan(
                          text: 'Cadastre-se',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Modular.to.pushNamed('/sign_up/');
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
