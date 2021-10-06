import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Controle de Estoque e Ordem de Serviço'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Text(
              'Bem vindo ao Controle de Estoque e Ordem de Serviço.',
              style: TextStyle(fontSize: 22),
            ),
          ),
          Center(child: Text('Para continuar, é necessário estar identificado.')),
          Center(
            child: Wrap(
              children: [
                OutlinedButton(
                  onPressed: () {
                    Modular.to.pushNamed('/login/');
                  },
                  child: Text('Fazer Login'),
                ),
                OutlinedButton(
                  onPressed: () {
                    Modular.to.pushNamed('/sign_up/');
                  },
                  child: Text('Criar Conta'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
