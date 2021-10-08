import 'package:flutter/cupertino.dart';
import 'package:flutter_triple/flutter_triple.dart';

abstract class StoreContract<Error extends Object, State extends Object> extends NotifierStore<Error, State> {
  StoreContract(State initialState) : super(initialState);

  Future<void> findAll() async {
    throw ErrorDescription('Not implemented');
  }
}
