import 'package:controle_de_estoque_e_os/modules/product/product_store.dart';
import 'package:controle_de_estoque_e_os/shared/widgets/card_widget.dart';
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
  @override
  void initState() {
    store.findAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScopedBuilder<ProductStore, ErrorDescription, ProductState>.transition(
        transition: (context, child) => AnimatedSwitcher(
          duration: Duration(milliseconds: 400),
          child: child,
        ),
        onLoading: (context) => Center(
          child: CircularProgressIndicator(),
        ),
        onState: (context, state) {
          return CustomScrollView(
            scrollBehavior: CupertinoScrollBehavior(),
            slivers: [
              SliverAppBar(
                onStretchTrigger: () async {
                  store.findAll();
                },
                stretch: true,
                flexibleSpace: FlexibleSpaceBar(
                  stretchModes: [StretchMode.fadeTitle],
                  centerTitle: false,
                  title: Text('Produtos'),
                ),
                expandedHeight: 150,
              ),
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
                    child: Text('Ainda não existem produtos cadastrados.'),
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
