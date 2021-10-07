import 'package:controle_de_estoque_e_os/modules/product_brand/product_brand_repository.dart';
import 'package:controle_de_estoque_e_os/shared/models/product_brand_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_triple/flutter_triple.dart';

class ProductBrandStore extends NotifierStore<ErrorDescription, ProductBrandState> {
  ProductBrandStore({required this.repository}) : super(ProductBrandState(products: []));

  final ProductBrandRepository repository;

  Future<void> findAll() async {
    execute(
      () async => ProductBrandState(
        products: await repository.findAll(),
      ),
    );
  }

  Future<bool> createProductBrand({required String description}) async {
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
    this.products,
  });
  final List<ProductBrandModel>? products;
}
