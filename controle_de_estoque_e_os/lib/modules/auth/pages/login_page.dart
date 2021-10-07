import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_text_field/flutter_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final errorNotifier = ValueNotifier<String?>(null);
  final loginButtonFocus = FocusNode();

  Future<void> signIn() async {
    errorNotifier.value = null;
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      if (FirebaseAuth.instance.currentUser != null) {
        Modular.to.pop(true);
      }
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case 'user-not-found':
          errorNotifier.value = 'Usuário não encontrado.';
          break;
        case 'wrong-password':
          errorNotifier.value = 'Senha incorreta.';
          break;
        case 'user-disabled':
          errorNotifier.value = 'Usuário desabilitado.';
          break;
        case 'invalid-email':
          errorNotifier.value = 'Email inválido.';
          break;
      }
    } catch (error) {
      debugPrint(error.toString());
    }
  }

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
                  FlutterTextField.email(
                    controller: emailController,
                    labelText: 'Email',
                    required: true,
                  ),
                  FlutterTextField.senha(
                    controller: passwordController,
                    labelText: 'Senha',
                    validator: (password) => (password?.length ?? 0) >= 6 == true ? null : 'A senha deve ter pelo menos 6 caracteres',
                    nextFocus: loginButtonFocus,
                  ),
                  ValueListenableBuilder<String?>(
                    valueListenable: errorNotifier,
                    builder: (context, error, child) {
                      if (error != null) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              error,
                              style: TextStyle(color: Theme.of(context).errorColor),
                            ),
                          ),
                        );
                      }
                      return Container();
                    },
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlinedButton(
                        focusNode: loginButtonFocus,
                        onPressed: signIn,
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
                            ..onTap = () async {
                              final signed = await Modular.to.pushNamed('/sign_up/');
                              if (signed == true) {
                                Modular.to.pop(true);
                              }
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
