import 'package:controle_de_estoque_e_os/modules/product/product_store.dart';
import 'package:controle_de_estoque_e_os/services/api_service.dart';
import 'package:controle_de_estoque_e_os/shared/widgets/loading_widget.dart';
import 'package:controle_de_estoque_e_os/shared/widgets/scroll_view_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends ModularState<ProductsPage, ProductStore> {
  bool firstRenderFired = false;
  final loading = LoadingWidget(loadingMessage: 'Carregando Estoque');

  @override
  void initState() {
    store.findAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScopedBuilder<ProductStore, ApiError, ProductState>.transition(
        onLoading: (context) => loading,
        onState: (context, state) {
          if (!firstRenderFired) {
            firstRenderFired = true;
            return loading;
          }
          return ScrollViewWidget(
            appBarTitle: 'Estoque',
            onStretchTrigger: store.findAll,
            slivers: [
              if (state.products?.isNotEmpty == true)
                SliverList(
                  delegate: SliverChildListDelegate(
                    state.products
                            ?.map(
                              (product) => ListTile(
                                title: Text(product.description ?? ''),
                                subtitle: Text('Em estoque: ${product.quantityInStock ?? 0}'),
                                onTap: () {
                                  Modular.to.pushNamed('/products/${product.id}/');
                                },
                              ),
                            )
                            .toList() ??
                        [],
                  ),
                )
              else
                SliverToBoxAdapter(
                  child: Center(
                    child: Text('Ainda não existem produtos cadastrados no estoque.'),
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
        onPressed: () async {
          Modular.to.pushNamed('/products/add/');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
