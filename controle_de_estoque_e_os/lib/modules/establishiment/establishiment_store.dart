import 'package:flutter/cupertino.dart';
import 'package:flutter_triple/flutter_triple.dart';

import 'package:controle_de_estoque_e_os/modules/establishiment/establishiment_repository.dart';
import 'package:controle_de_estoque_e_os/shared/models/establishiment_model.dart';

class EstablishimentStore extends NotifierStore<ErrorDescription, EstablishimentState> {
  EstablishimentStore({required this.repository}) : super(EstablishimentState());

  final EstablishimentRepository repository;

  Future<bool> create({required EstalishimentModel estalishiment}) async {
    final result = await repository.create(estalishiment: estalishiment);
    return result != null;
  }
}

class EstablishimentState {
  EstablishimentState({this.establishiment});

  final EstalishimentModel? establishiment;
}
