import 'package:controle_de_estoque_e_os/modules/product_type/product_type_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

class ProductTypesPage extends StatefulWidget {
  const ProductTypesPage({Key? key}) : super(key: key);

  @override
  _ProductTypesPageState createState() => _ProductTypesPageState();
}

class _ProductTypesPageState extends ModularState<ProductTypesPage, ProductTypeStore> {
  @override
  void initState() {
    store.findAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tipos de produto'),
      ),
      body: ScopedBuilder<ProductTypeStore, ErrorDescription, ProductTypeState>(
        store: store,
        onLoading: (context) => Center(
          child: CircularProgressIndicator(),
        ),
        onState: (context, state) {
          if (state.products?.isEmpty == true) {
            return Center(
              child: Text('Nenhum tipo de produto encontrado.'),
            );
          }
          return CustomScrollView(
            scrollBehavior: CupertinoScrollBehavior(),
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate(
                  state.products
                          ?.map(
                            (e) => ListTile(
                              title: Text(e.description ?? ''),
                            ),
                          )
                          .toList() ??
                      [],
                ),
              ),
            ],
          );
        },
        onError: (context, error) => Center(
          child: Text(error.toString()),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Modular.to.pushNamed('/product_types/add/');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
