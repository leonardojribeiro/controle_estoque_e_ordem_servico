import 'package:controle_de_estoque_e_os/modules/establishiment/establishiment_store.dart';
import 'package:controle_de_estoque_e_os/shared/models/establishiment_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_text_field/flutter_text_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends ModularState<SignUpPage, EstablishimentStore> {
  final displayNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final pageController = PageController();
  final firstFormKey = GlobalKey<FormState>();
  final secondFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criar conta'),
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
                  SizedBox(
                    height: 300,
                    child: PageView(
                      controller: pageController,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Olá! Para criar uma conta, informe o nome fantasia de sua empresa.',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            Form(
                              key: firstFormKey,
                              child: TextFormField(
                                controller: displayNameController,
                                decoration: InputDecoration(
                                  labelText: 'Nome Fantasia',
                                ),
                                validator: (displayName) => displayName?.isEmpty == true ? 'Informe o nome fantasia' : null,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  OutlinedButton(
                                    onPressed: () {
                                      if (firstFormKey.currentState?.validate() == true) {
                                        pageController.nextPage(duration: const Duration(milliseconds: 350), curve: Curves.ease);
                                      }
                                    },
                                    child: Text('Próximo'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Agora, crie o seu usuário.',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            Form(
                              key: secondFormKey,
                              child: Column(
                                children: [
                                  FlutterTextField.email(
                                    controller: emailController,
                                    labelText: 'Email',
                                    required: true,
                                  ),
                                  FlutterTextField.senha(
                                    controller: passwordController,
                                    labelText: 'Senha',
                                    required: true,
                                    validator: (password) => (password?.length ?? 0) >= 6 == true ? null : 'A senha deve ter pelo menos 6 caracteres',
                                  ),
                                  FlutterTextField.senha(
                                    controller: confirmPasswordController,
                                    labelText: 'Confirme sua Senha',
                                    required: true,
                                    validator: (password) {
                                      if (password != passwordController.text) {
                                        return 'As senhas não conferem';
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  OutlinedButton(
                                    onPressed: () {
                                      pageController.previousPage(duration: const Duration(milliseconds: 350), curve: Curves.ease);
                                    },
                                    child: Text('Voltar'),
                                  ),
                                  OutlinedButton(
                                    onPressed: () async {
                                      if (secondFormKey.currentState?.validate() == true) {
                                        final credentials = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text);
                                        print('credentials.credential');
                                        print(credentials.credential);
                                        if (credentials.user != null) {
                                          print('aq');
                                          final result = await store.create(
                                            estalishiment: EstalishimentModel(
                                              displayName: displayNameController.text,
                                            ),
                                          );
                                          print(result);
                                          if (!result) {
                                            await credentials.user?.delete();
                                          }
                                        }
                                      }
                                    },
                                    child: Text('Criar Conta'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Text.rich(
                    TextSpan(
                      text: 'Já tem uma conta? ',
                      children: [
                        TextSpan(
                          text: 'Faça login',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Modular.to.pushReplacementNamed('/login/');
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
