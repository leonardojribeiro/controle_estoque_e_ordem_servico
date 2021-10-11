import 'package:controle_de_estoque_e_os/modules/client/client_store.dart';
import 'package:controle_de_estoque_e_os/services/api_service.dart';
import 'package:controle_de_estoque_e_os/shared/widgets/loading_widget.dart';
import 'package:controle_de_estoque_e_os/shared/widgets/scroll_view_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

class ClientsPage extends StatefulWidget {
  const ClientsPage({Key? key}) : super(key: key);

  @override
  _ClientsPageState createState() => _ClientsPageState();
}

class _ClientsPageState extends ModularState<ClientsPage, ClientStore> {
  bool firstRenderFired = false;
  final loading = LoadingWidget(loadingMessage: 'Carregando Clientes');

  @override
  void initState() {
    store.findAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScopedBuilder<ClientStore, ApiError, ClientState>.transition(
        onLoading: (context) => loading,
        onState: (context, state) {
          if (!firstRenderFired) {
            firstRenderFired = true;
            return loading;
          }
          return ScrollViewWidget(
            appBarTitle: 'Clientes',
            onStretchTrigger: store.findAll,
            slivers: [
              if (state.products?.isNotEmpty == true)
                SliverList(
                  delegate: SliverChildListDelegate(
                    state.products
                            ?.map(
                              (e) => ListTile(
                                title: Text(e.fullName ?? ''),
                                onTap: () {
                                  Modular.to.pushNamed('/clients/${e.id}/');
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
                    child: Text('Ainda não existem clientes cadastrados.'),
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
          Modular.to.pushNamed('/clients/add/');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
