import 'package:controle_de_estoque_e_os/shared/widgets/card_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
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
      body: CustomScrollView(
        scrollBehavior: CupertinoScrollBehavior(),
        slivers: [
          SliverAppBar(
            expandedHeight: 150,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Login'),
            ),
            stretch: true,
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 150,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Olá!',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Para organizar seu estoque, você precisa estar identificado.',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FlutterTextField.email(
                            controller: emailController,
                            labelText: 'Email',
                            required: true,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FlutterTextField.senha(
                            controller: passwordController,
                            labelText: 'Senha',
                            validator: (password) => (password?.length ?? 0) >= 6 == true ? null : 'A senha deve ter pelo menos 6 caracteres',
                            nextFocus: loginButtonFocus,
                          ),
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
                      ],
                    ),
                    Column(
                      children: [
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text.rich(
                            TextSpan(
                              text: 'Não tem um login? ',
                              children: [
                                TextSpan(
                                  text: 'Cadastre-se',
                                  style: TextStyle(
                                    color: Theme.of(context).textTheme.button?.color,
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
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
