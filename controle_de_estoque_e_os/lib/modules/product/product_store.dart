import 'package:controle_de_estoque_e_os/services/api_service.dart';
import 'package:controle_de_estoque_e_os/modules/product/product_repository.dart';
import 'package:controle_de_estoque_e_os/modules/product_brand/product_brand_repository.dart';
import 'package:controle_de_estoque_e_os/modules/product_type/product_type_repository.dart';
import 'package:controle_de_estoque_e_os/shared/models/product_brand_model.dart';
import 'package:controle_de_estoque_e_os/shared/models/product_model.dart';
import 'package:controle_de_estoque_e_os/shared/models/product_type_model.dart';
import 'package:flutter_triple/flutter_triple.dart';

class ProductStore extends NotifierStore<ApiError, ProductState> {
  ProductStore({
    required this.repository,
    required this.productTypeRepository,
    required this.productBrandRepository,
  }) : super(ProductState());

  final ProductRepository repository;
  final ProductTypeRepository productTypeRepository;
  final ProductBrandRepository productBrandRepository;

  Future<void> refresh() async => execute(
        () async => state.copyWith(
          product: await repository.findById(id: state.product?.id ?? ''),
          products: await repository.findAll(),
        ),
      );

  Future<void> findAll() async => execute(
        () async => state.copyWith(
          products: await repository.findAll(),
        ),
      );

  Future<void> findById({required String id}) async => execute(
        () async => state.copyWith(
          product: await repository.findById(id: id),
        ),
      );

  Future<bool> create({required ProductModel product}) async {
    final result = await repository.create(product: product);
    final success = result != null;
    if (success) {
      findAll();
    }
    return success;
  }

  Future<bool> updateProduct({required ProductModel product}) async {
    final result = await repository.update(product: product);
    final success = result != null;
    if (success) {
      refresh();
    }
    return success;
  }

  Future<bool> addStock({required int quantity}) async {
    final result = await repository.addStock(id: state.product?.id ?? '', quantity: quantity);
    final success = result != null;
    if (success) {
      refresh();
    }
    return success;
  }

  Future<bool> removeStock({required int quantity}) async {
    final result = await repository.removeStock(id: state.product?.id ?? '', quantity: quantity);
    final success = result != null;
    if (success) {
      refresh();
    }
    return success;
  }

  Future<bool> refreshStock({required int quantity}) async {
    final result = await repository.refreshStock(id: state.product?.id ?? '', quantity: quantity);
    final success = result != null;
    if (success) {
      refresh();
    }
    return success;
  }

  Future<void> fetchTypesAndBrands() async {
    execute(
      () async => state.copyWith(
        typesAndBrands: TypesAndBrands(
          productBrands: await productBrandRepository.findAll(),
          productTypes: await productTypeRepository.findAll(),
        ),
      ),
    );
  }

  Future<void> fetchTypesBrandsAndProductById({required String id}) async {
    execute(
      () async => state.copyWith(
        product: await repository.findById(id: id),
        typesAndBrands: TypesAndBrands(
          productBrands: await productBrandRepository.findAll(),
          productTypes: await productTypeRepository.findAll(),
        ),
      ),
    );
  }
}

class ProductState {
  ProductState({
    this.products,
    this.product,
    this.typesAndBrands,
  });
  final List<ProductModel>? products;
  final ProductModel? product;
  final TypesAndBrands? typesAndBrands;

  ProductState copyWith({
    List<ProductModel>? products,
    ProductModel? product,
    TypesAndBrands? typesAndBrands,
  }) {
    return ProductState(
      products: products ?? this.products,
      product: product ?? this.product,
      typesAndBrands: typesAndBrands ?? this.typesAndBrands,
    );
  }
}

class TypesAndBrands {
  TypesAndBrands({required this.productBrands, required this.productTypes});
  final List<ProductBrandModel> productBrands;
  final List<ProductTypeModel> productTypes;
}
