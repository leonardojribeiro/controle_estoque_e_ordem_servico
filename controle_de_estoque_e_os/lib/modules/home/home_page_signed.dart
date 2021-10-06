import 'package:controle_de_estoque_e_os/modules/auth/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePageSigned extends StatefulWidget {
  const HomePageSigned({Key? key}) : super(key: key);

  @override
  _HomePageSignedState createState() => _HomePageSignedState();
}

class _HomePageSignedState extends State<HomePageSigned> {
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
              Modular.to.pushNamed('/product_brands/');
            },
            child: Text('Marcas de produto'),
          ),
          OutlinedButton(
            onPressed: () {
              Modular.to.pushNamed('/products/');
            },
            child: Text('Produtos'),
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
