import 'package:controle_de_estoque_e_os/modules/product_brand/product_brand_repository.dart';
import 'package:controle_de_estoque_e_os/shared/models/product_brand_model.dart';
import 'package:controle_de_estoque_e_os/shared/models/product_type_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_triple/flutter_triple.dart';

import 'package:controle_de_estoque_e_os/modules/product/product_repository.dart';
import 'package:controle_de_estoque_e_os/modules/product_type/product_type_repository.dart';
import 'package:controle_de_estoque_e_os/shared/models/product_model.dart';

class ProductStore extends NotifierStore<ErrorDescription, ProductState> {
  ProductStore({
    required this.repository,
    required this.productTypeRepository,
    required this.productBrandRepository,
  }) : super(ProductState(products: []));

  final ProductRepository repository;
  final ProductTypeRepository productTypeRepository;
  final ProductBrandRepository productBrandRepository;

  Future<void> findAll() async {
    execute(
      () async => ProductState(
        products: await repository.findAll(),
      ),
    );
  }

  Future<bool> createProduct({required String description}) async {
    final result = await repository.create(description: description);
    final success = result != null;
    if (success) {
      findAll();
    }
    return success;
  }

  Future<void> fetchTypesAndBrands() async {
    execute(
      () async => ProductState(
        typesAndBrands: TypesAndBrands(
          productBrands: await productBrandRepository.findAll(),
          productTypes: await productTypeRepository.findAll(),
        ),
      ),
    );
  }
}

class ProductState {
  ProductState({this.products, this.typesAndBrands});
  final List<ProductModel>? products;
  final TypesAndBrands? typesAndBrands;
}

class TypesAndBrands {
  TypesAndBrands({required this.productBrands, required this.productTypes});
  final List<ProductBrandModel> productBrands;
  final List<ProductTypeModel> productTypes;
}
