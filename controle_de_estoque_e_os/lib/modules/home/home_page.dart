import 'package:controle_de_estoque_e_os/modules/auth/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Controle de Estoque e OS'),
      ),
      body: Wrap(
        children: [
          OutlinedButton(
            onPressed: () {
              Modular.to.pushNamed('/product_types/');
            },
            child: Text('Tipos de produto'),
          ),
          OutlinedButton(
            onPressed: () {
              Modular.get<AuthController>().auth.signOut();
            },
            child: Text('Sair'),
          ),
        ],
      ),
    );
  }
}
