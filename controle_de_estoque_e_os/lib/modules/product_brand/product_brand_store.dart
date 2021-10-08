import 'package:controle_de_estoque_e_os/modules/product_brand/product_brand_repository.dart';
import 'package:controle_de_estoque_e_os/shared/models/product_brand_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_triple/flutter_triple.dart';

class ProductBrandStore extends NotifierStore<ErrorDescription, ProductBrandState> {
  ProductBrandStore({required this.repository}) : super(ProductBrandState(productBrands: []));

  final ProductBrandRepository repository;

  Future<void> findAll() async {
    execute(
      () async => ProductBrandState(
        productBrands: await repository.findAll(),
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

class ProductBrandState {
  ProductBrandState({
    this.productBrands,
  });
  final List<ProductBrandModel>? productBrands;
}
