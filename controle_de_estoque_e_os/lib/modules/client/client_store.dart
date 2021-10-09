import 'package:controle_de_estoque_e_os/services/api_service.dart';
import 'package:flutter_triple/flutter_triple.dart';

import 'package:controle_de_estoque_e_os/modules/client/client_repository.dart';
import 'package:controle_de_estoque_e_os/shared/models/client_model.dart';

class ClientStore extends NotifierStore<ApiError, ClientState> {
  ClientStore({required this.repository}) : super(ClientState(products: []));

  final ClientRepository repository;

  Future<void> findAll() async {
    execute(
      () async => state.copyWith(
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

  Future<void> findById({required String id}) async => execute(
        () async => state.copyWith(
          client: await repository.findById(
            id: id,
          ),
        ),
      );
}

class ClientState {
  ClientState({
    this.products,
    this.client,
  });

  final List<ClientModel>? products;
  final ClientModel? client;

  ClientState copyWith({
    List<ClientModel>? products,
    ClientModel? client,
  }) {
    return ClientState(
      products: products ?? this.products,
      client: client ?? this.client,
    );
  }

  @override
  String toString() => 'ClientState(products: $products, client: $client)';
}
