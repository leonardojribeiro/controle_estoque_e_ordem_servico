import 'package:controle_de_estoque_e_os/modules/product_brand/product_brand_store.dart';
import 'package:controle_de_estoque_e_os/services/api_service.dart';
import 'package:controle_de_estoque_e_os/shared/widgets/scroll_view_widget.dart';
import 'package:flutter/cupertino.dart';
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

  bool firstRenderFired = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScopedBuilder<ProductBrandStore, ApiError, ProductBrandState>.transition(
        onLoading: (context) => Center(
          child: CircularProgressIndicator(),
        ),
        onState: (context, state) {
          if (!firstRenderFired) {
            firstRenderFired = true;
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ScrollViewWidget(
            appBarTitle: 'Marcas de produto',
            onStretchTrigger: store.findAll,
            slivers: [
              if (state.productBrands?.isNotEmpty == true)
                SliverList(
                  delegate: SliverChildListDelegate(
                    state.productBrands
                            ?.map(
                              (e) => ListTile(
                                title: Text(e.description ?? ''),
                              ),
                            )
                            .toList() ??
                        [],
                  ),
                )
              else
                SliverToBoxAdapter(
                  child: Center(
                    child: Text('Ainda não existem marcas de produto cadastradas.'),
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
          Modular.to.pushNamed('/product_brands/add/');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
