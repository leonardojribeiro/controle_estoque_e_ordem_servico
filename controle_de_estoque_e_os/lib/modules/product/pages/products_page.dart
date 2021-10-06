import 'package:controle_de_estoque_e_os/modules/product/product_store.dart';
import 'package:controle_de_estoque_e_os/modules/product_brand/product_brand_store.dart';
import 'package:controle_de_estoque_e_os/shared/enums/store_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends ModularState<ProductsPage, ProductStore> {
  @override
  void initState() {
    store.findAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Produtos'),
      ),
      body: ScopedBuilder<ProductStore, ErrorDescription, ProductState>(
        store: store,
        onLoading: (context) => Center(
          child: CircularProgressIndicator(),
        ),
        onState: (context, state) {
          if (state.products == null || state.products?.isEmpty == true) {
            return Center(
              child: Text('Nenhum produto encontrado.'),
            );
          }
          return SingleChildScrollView(
            child: Column(
              children: state.products
                      ?.map(
                        (e) => ListTile(
                          title: Text(e.description ?? ''),
                        ),
                      )
                      .toList() ??
                  [],
            ),
          );
        },
        onError: (context, error) => Center(
          child: Text(error.toString()),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Modular.to.pushNamed('/products/add/');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
