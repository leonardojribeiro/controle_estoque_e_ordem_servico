import 'package:controle_de_estoque_e_os/modules/product_type/product_type_store.dart';
import 'package:controle_de_estoque_e_os/services/api_service.dart';
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

  bool firstRenderFired = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScopedBuilder<ProductTypeStore, ApiError, ProductTypeState>.transition(
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
                  title: Text('Tipos de produto'),
                ),
                expandedHeight: 150,
              ),
              if (state.productTypes?.isNotEmpty == true)
                SliverList(
                  delegate: SliverChildListDelegate(
                    state.productTypes
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
                    child: Text('Ainda não existem tipos de produto cadastrados.'),
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
