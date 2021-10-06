import 'package:controle_de_estoque_e_os/services/api_service.dart';
import 'package:controle_de_estoque_e_os/shared/models/establishiment_model.dart';
import 'package:flutter_modular/flutter_modular.dart';

class EstablishimentRepository {
  Future<dynamic> create({required EstalishimentModel estalishiment}) async {
    return Modular.get<ApiService>().post(
      url: 'establishiments',
      data: estalishiment.toMap(),
    );
  }
}
