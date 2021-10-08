import 'package:controle_de_estoque_e_os/modules/client/client_repository.dart';
import 'package:controle_de_estoque_e_os/shared/models/client_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_triple/flutter_triple.dart';

class ClientStore extends NotifierStore<ErrorDescription, ClientState> {
  ClientStore({required this.repository}) : super(ClientState(products: []));

  final ClientRepository repository;

  Future<void> findAll() async {
    execute(
      () async => ClientState(
        products: await repository.findAll(),
      ),
    );
  }

  Future<bool> create({required ClientModel client}) async {
    final result = await repository.create(client: client);
    final success = result != null;
    if (success) {
      findAll();
    }
    return success;
  }
}

class ClientState {
  ClientState({this.products});
  final List<ClientModel>? products;
}
