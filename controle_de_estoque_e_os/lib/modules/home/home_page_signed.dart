import 'package:controle_de_estoque_e_os/modules/auth/auth_controller.dart';
import 'package:controle_de_estoque_e_os/shared/widgets/scroll_view_widget.dart';
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
    return ScrollViewWidget(
      appBarTitle: 'Controle de Estoque e Ordens de Serviço',
      slivers: [
        SliverGrid.count(
          crossAxisCount: MediaQuery.of(context).size.width ~/ 150,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
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
                Modular.to.pushNamed('/clients/');
              },
              child: Text('Clientes'),
            ),
            OutlinedButton(
              onPressed: () {
                Modular.get<AuthController>().signOut();
              },
              child: Text('Sair'),
            ),
            OutlinedButton(
              onPressed: () async {
                print(await Modular.get<AuthController>().getToken());
              },
              child: Text('printar token'),
            ),
          ],
        ),
      ],
    );
  }
}
