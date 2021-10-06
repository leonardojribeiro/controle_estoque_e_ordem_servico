import 'package:controle_de_estoque_e_os/modules/product_type/product_type_repository.dart';
import 'package:controle_de_estoque_e_os/shared/enums/store_state.dart';
import 'package:controle_de_estoque_e_os/shared/models/product_type_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_triple/flutter_triple.dart';

class ProductTypeStore extends NotifierStore<ErrorDescription, ProductTypeState> {
  ProductTypeStore({required this.repository}) : super(ProductTypeState(products: []));

  final ProductTypeRepository repository;

  Future<void> findAll() async {
    execute(
      () async => ProductTypeState(
        products: await repository.findAll(),
        state: StoreState.available,
      ),
    );
  }

  Future<bool> createProductType({required String description}) async {
    final result = await repository.createProduct(description: description);
    final success = result != null;
    if (success) {
      findAll();
    }
    return success;
  }
}

class ProductTypeState {
  final List<ProductTypeModel> products;
  final StoreState state;
  ProductTypeState({required this.products, this.state = StoreState.initial});
}
