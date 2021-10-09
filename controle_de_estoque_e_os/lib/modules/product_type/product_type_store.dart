import 'package:controle_de_estoque_e_os/modules/product_type/product_type_repository.dart';
import 'package:controle_de_estoque_e_os/services/api_service.dart';
import 'package:controle_de_estoque_e_os/shared/models/product_type_model.dart';
import 'package:flutter_triple/flutter_triple.dart';

class ProductTypeStore extends NotifierStore<ApiError, ProductTypeState> {
  ProductTypeStore({required this.repository}) : super(ProductTypeState(productTypes: []));

  final ProductTypeRepository repository;

  Future<void> findAll() async {
    execute(
      () async => ProductTypeState(
        productTypes: await repository.findAll(),
      ),
    );
  }

  Future<bool> create({required String description}) async {
    final result = await repository.create(description: description);
    final success = result != null;
    if (success) {
      findAll();
    }
    return success;
  }
}

class ProductTypeState {
  ProductTypeState({this.productTypes});
  final List<ProductTypeModel>? productTypes;
}
