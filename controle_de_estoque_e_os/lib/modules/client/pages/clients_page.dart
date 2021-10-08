import 'package:controle_de_estoque_e_os/modules/client/client_store.dart';
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
  @override
  void initState() {
    store.findAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScopedBuilder<ClientStore, ErrorDescription, ClientState>.transition(
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
                  title: Text('Clientes'),
                ),
                expandedHeight: 150,
              ),
              if (state.products?.isNotEmpty == true)
                SliverList(
                  delegate: SliverChildListDelegate(
                    state.products
                            ?.map(
                              (e) => ListTile(
                                title: Text(e.fullName ?? ''),
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
