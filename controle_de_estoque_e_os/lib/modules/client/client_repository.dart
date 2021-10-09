import 'package:controle_de_estoque_e_os/services/api_service.dart';
import 'package:controle_de_estoque_e_os/shared/models/client_model.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ClientRepository {
  Future<List<ClientModel>> findAll() async {
    final products = await Modular.get<ApiService>().get(url: 'clients');
    if (products is List) {
      return products.map((e) => ClientModel.fromMap(e)).toList();
    }
    return [];
  }

  Future<dynamic> create({required ClientModel client}) async {
    return Modular.get<ApiService>().post(
      url: 'clients',
      data: client.toMap(),
    );
  }

  Future<ClientModel?> findById({required String id}) async {
    final client = await Modular.get<ApiService>().get(
      url: 'clients/$id',
    );
    print(client);
    if (client != null) {
      return ClientModel.fromMap(client);
    }
  }
}
