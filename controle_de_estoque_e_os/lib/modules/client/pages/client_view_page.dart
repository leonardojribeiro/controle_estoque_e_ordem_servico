import 'package:controle_de_estoque_e_os/services/api_service.dart';
import 'package:controle_de_estoque_e_os/shared/widgets/scroll_view_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import 'package:controle_de_estoque_e_os/modules/client/client_store.dart';

class ClientViewPage extends StatefulWidget {
  const ClientViewPage({
    Key? key,
    this.clientId,
  }) : super(key: key);
  final String? clientId;
  @override
  _ClientViewPageState createState() => _ClientViewPageState();
}

class _ClientViewPageState extends ModularState<ClientViewPage, ClientStore> {
  @override
  void initState() {
    store.findById(id: widget.clientId ?? '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScopedBuilder<ClientStore, ApiError, ClientState>.transition(
        onLoading: (context) => Center(
          child: CircularProgressIndicator(),
        ),
        onState: (context, state) {
          return ScrollViewWidget(
            appBarTitle: state.client?.fullName ?? '',
            onStretchTrigger: () => store.findById(id: widget.clientId ?? ''),
            slivers: [],
            floatingActionButton: FloatingActionButton(
              heroTag: '/clients/${widget.clientId}/update/',
              onPressed: () {
                Modular.to.pushNamed('/clients/${widget.clientId}/update/');
              },
            ),
          );
        },
      ),
    );
  }
}
