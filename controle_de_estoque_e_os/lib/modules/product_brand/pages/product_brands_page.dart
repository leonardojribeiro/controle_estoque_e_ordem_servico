import 'package:controle_de_estoque_e_os/modules/product_brand/product_brand_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

class ProductBrandsPage extends StatefulWidget {
  const ProductBrandsPage({Key? key}) : super(key: key);

  @override
  _ProductBrandsPageState createState() => _ProductBrandsPageState();
}

class _ProductBrandsPageState extends ModularState<ProductBrandsPage, ProductBrandStore> {
  @override
  void initState() {
    store.findAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Marcas de produto'),
      ),
      body: ScopedBuilder<ProductBrandStore, ErrorDescription, ProductBrandState>(
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
          Modular.to.pushNamed('/product_brands/add/');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
